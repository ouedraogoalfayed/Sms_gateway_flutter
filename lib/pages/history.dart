import 'package:flutter/material.dart';
import '../services/sms_listeneing.dart'; 
import '../services/sms_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryItem> historyItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      isLoading = true;
    });

    try {
      final history = await SmsService.getHistory();
      setState(() {
        historyItems = history;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur lors du chargement de l'historique: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _clearHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Effacer l\'historique'),
        content: Text('Voulez-vous vraiment effacer tout l\'historique ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Effacer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await SmsService.clearHistory();
      await _loadHistory();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Historique effacé')),
      );
    }
  }

  // Calculer le nombre total d'éléments (en aplatissant les endpoints)
  int _getTotalItemsCount() {
    int count = 0;
    for (final item in historyItems) {
      count += item.endpoints.length;
    }
    return count;
  }

  // Obtenir l'élément aplati à l'index donné
  FlatHistoryItem _getFlatItem(int index) {
    int currentIndex = 0;
    
    for (final item in historyItems) {
      for (final endpoint in item.endpoints) {
        if (currentIndex == index) {
          return FlatHistoryItem(
            senderAddress: item.senderAddress,
            date: item.date,
            endpoint: endpoint,
          );
        }
        currentIndex++;
      }
    }
    
    throw RangeError('Index out of bounds');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Historique',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black87),
            onPressed: _loadHistory,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                _clearHistory();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Effacer l\'historique'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : historyItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Aucun historique',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Les SMS transférés apparaîtront ici',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _getTotalItemsCount(),
                  itemBuilder: (context, index) {
                    final flatItem = _getFlatItem(index);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Status Icon
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getStatusColor(flatItem.endpoint.status),
                                shape: BoxShape.circle,
                              ),
                              child: _getStatusIcon(flatItem.endpoint.status),
                            ),
                            SizedBox(width: 16),
                            
                            // Content
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left side - SMS Address and Date
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        flatItem.senderAddress,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        _formatDate(flatItem.date),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  // Right side - Endpoint details
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        flatItem.endpoint.endpointName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        _extractPath(flatItem.endpoint.endpointUrl),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  

  // Formatage de la date
  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return isoDate;
    }
  }

  // Extraire le chemin de l'URL
  String _extractPath(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.path.isEmpty ? '/' : uri.path;
    } catch (e) {
      return url;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
        return Colors.green;
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  Widget _getStatusIcon(String status, {double size = 24}) {
    switch (status) {
      case 'success':
        return Icon(Icons.check, color: Colors.white, size: size);
      case 'error':
        return Icon(Icons.close, color: Colors.white, size: size);
      case 'warning':
        return Icon(Icons.warning, color: Colors.white, size: size);
      default:
        return Icon(Icons.check, color: Colors.white, size: size);
    }
  }
}