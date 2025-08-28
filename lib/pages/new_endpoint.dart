import 'package:flutter/material.dart';
import '../services/new_form.dart';

/*import 'package:flutter/material.dart';
import '../services/new_form.dart';

class new_endpoint extends StatefulWidget {
  final VoidCallback onClose;

  const new_endpoint({super.key, required this.onClose});

  @override
  State<new_endpoint> createState() => _new_endpointState();
}

class _new_endpointState extends State<new_endpoint> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  String _selectedMethod = 'POST';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final data = await new_formService.loadnew_form();
    setState(() {
      _nameController.text = data['name'] ?? '';
      _urlController.text = data['url'] ?? '';
      _selectedMethod = data['method'] ?? 'POST'; 
      _isLoading = false;
    });
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      await new_formService.savenew_form(
        name: _nameController.text,
        url: _urlController.text,
        method: _selectedMethod, 
      );

    showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Succès'),
    content: Text('Données sauvegardées'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/'),
        child: Text('OK'),
      ),
    ],
  ),
);
      
    }
  }

  Future<void> _clearForm() async {
    await new_formService.clearnew_form();
    setState(() {
      _nameController.clear();
      _urlController.clear();
      _selectedMethod = 'POST'; 
    });
    
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fond semi-transparent
        GestureDetector(
          onTap: widget.onClose,
          child: Container(
            color: const Color.fromARGB(255, 138, 137, 137),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Formulaire centré
        Center(
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // En-tête
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Formulaire',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () { if (mounted) Navigator.pop(context);},
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Champ Nom
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nom',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer le nom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Champ url
                          TextFormField(
                            controller: _urlController,
                            decoration: const InputDecoration(
                              labelText: 'URL',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.link),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre URL';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Boutons Radio pour la Méthode
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Méthode *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          Row(
                            children: [
                              // Bouton Radio GET
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('GET'),
                                  value: 'GET',
                                  groupValue: _selectedMethod,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedMethod = value!;
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                              
                              // Bouton Radio POST
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('POST'),
                                  value: 'POST',
                                  groupValue: _selectedMethod,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedMethod = value!;
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Boutons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _clearForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                                child: const Text('Effacer'),
                              ),
                              ElevatedButton(
                                onPressed:() async {
                                   if (_formKey.currentState!.validate()) {
                                     await _saveForm();
                                     // Sauvegarde seulement si valide 
                                     print('Nom: ${_nameController.text}');
print('URL: ${_urlController.text}');
print('Méthode: $_selectedMethod');
                                  }
    // Si non valide, ne rien faire (les erreurs s'affichent)
                                   },
                                child: const Text('Sauvegarder'),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}*/

// Écran de formulaire pour ajouter/modifier un endpoint
class EndpointFormScreen extends StatefulWidget {
  final Endpoint? endpoint;

  const EndpointFormScreen({super.key, this.endpoint});

  @override
  _EndpointFormScreenState createState() => _EndpointFormScreenState();
}

class _EndpointFormScreenState extends State<EndpointFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _urlController;
  String _selectedMethod = 'GET';
  bool _isEnabled = true;

  final List<String> _methods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.endpoint?.name ?? '');
    _urlController = TextEditingController(text: widget.endpoint?.url ?? '');
    _selectedMethod = widget.endpoint?.method ?? 'GET';
    _isEnabled = widget.endpoint?.isEnabled ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3E50),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C3E50),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          widget.endpoint == null ? 'Nouvel Endpoint' : 'Modifier Endpoint',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nom
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nom de l\'endpoint',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Ex: User Login API',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un nom';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              // URL
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'URL',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        hintText: 'https://api.example.com/login',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une URL';
                        }
                        if (!value.startsWith('http')) {
                          return 'L\'URL doit commencer par http:// ou https://';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              // Méthode HTTP
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Méthode HTTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedMethod,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _methods.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              // État activé/désactivé
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Endpoint activé',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: _isEnabled,
                      onChanged: (value) {
                        setState(() {
                          _isEnabled = value;
                        });
                      },
                      activeColor: Color(0xFF26A69A),
                    ),
                  ],
                ),
              ),
              
              Spacer(),
              
              // Bouton sauvegarder
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveEndpoint,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF26A69A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.endpoint == null ? 'Créer l\'endpoint' : 'Sauvegarder',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveEndpoint() {
    if (_formKey.currentState!.validate()) {
      final endpoint = Endpoint(
        id: widget.endpoint?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        url: _urlController.text,
        method: _selectedMethod,
        isEnabled: _isEnabled,
      );
      
      Navigator.pop(context, endpoint);
    }
  }
}