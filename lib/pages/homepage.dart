import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/new_form.dart';
import 'new_endpoint.dart';
import '../services/sms_listeneing.dart';


class EndpointsScreen extends StatefulWidget {
  const EndpointsScreen({super.key});

  @override
  _EndpointsScreenState createState() => _EndpointsScreenState();
}

class _EndpointsScreenState extends State<EndpointsScreen> {
  List<Endpoint> endpoints = [];

  @override
  void initState() {
    super.initState();
    _loadEndpoints();

  }



  // Charger les endpoints depuis SharedPreferences
  _loadEndpoints() async {
    final prefs = await SharedPreferences.getInstance();
    final endpointsJson = prefs.getStringList('endpoints') ?? [];
    
    setState(() {
      endpoints = endpointsJson
          .map((json) => Endpoint.fromJson(jsonDecode(json)))
          .toList();
    });
  }

  // Sauvegarder les endpoints dans SharedPreferences
  _saveEndpoints() async {
    final prefs = await SharedPreferences.getInstance();
    final endpointsJson = endpoints
        .map((endpoint) => jsonEncode(endpoint.toJson()))
        .toList();
    
    await prefs.setStringList('endpoints', endpointsJson);

    await SmsService.refreshSmsListening();
  }

  // Naviguer vers le formulaire d'ajout/modification
  _navigateToForm({Endpoint? endpoint}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EndpointFormScreen(endpoint: endpoint),
      ),
    );
    
    if (result != null) {
      setState(() {
        if (endpoint == null) {
          // Ajouter nouvel endpoint
          endpoints.add(result);
        } else {
          // Modifier endpoint existant
          final index = endpoints.indexWhere((e) => e.id == endpoint.id);
          if (index != -1) {
            endpoints[index] = result;
          }
        }
      });
      await _saveEndpoints();
    }
  }

  // Supprimer un endpoint
  _deleteEndpoint(String id) async {
    setState(() {
      endpoints.removeWhere((e) => e.id == id);
    });
    await _saveEndpoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3E50),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Mes Endpoints',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Liste des endpoints
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: endpoints.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.api,
                              size: 64,
                              color: Colors.white54,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Aucun endpoint configuré',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: endpoints.length,
                        itemBuilder: (context, index) {
                          final endpoint = endpoints[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: _buildEndpointCard(endpoint),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        backgroundColor: Color(0xFF26A69A),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildEndpointCard(Endpoint endpoint) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Informations de l'endpoint
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      endpoint.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      endpoint.url,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getMethodColor(endpoint.method).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        endpoint.method,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _getMethodColor(endpoint.method),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Switch pour activer/désactiver
              Switch(
                value: endpoint.isEnabled,
                onChanged: (value) async{
                  setState(() {
                    endpoint.isEnabled = value;
                  });
                  await _saveEndpoints();
                },
                activeColor: Color(0xFF26A69A),
              ),
            ],
          ),
          
          SizedBox(height: 12),
          
          // Boutons d'action
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _navigateToForm(endpoint: endpoint),
                icon: Icon(Icons.edit, size: 16, color: Colors.blue),
                label: Text(
                  'Modifier',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => _showDeleteConfirmation(endpoint),
                icon: Icon(Icons.delete, size: 16, color: Colors.red),
                label: Text(
                  'Supprimer',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getMethodColor(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return Colors.green;
      case 'POST':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  _showDeleteConfirmation(Endpoint endpoint) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer l\'endpoint'),
          content: Text('Êtes-vous sûr de vouloir supprimer "${endpoint.name}" ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEndpoint(endpoint.id);
              },
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}