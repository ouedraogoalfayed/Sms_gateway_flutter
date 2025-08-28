// Modèle pour un endpoint
class Endpoint {
  String id;
  String name;
  String url;
  String method;
  bool isEnabled;

  Endpoint({
    required this.id,
    required this.name,
    required this.url,
    required this.method,
    this.isEnabled = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'method': method,
      'isEnabled': isEnabled,
    };
  }

  factory Endpoint.fromJson(Map<String, dynamic> json) {
    return Endpoint(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      method: json['method'],
      isEnabled: json['isEnabled'],
    );
  }
}
