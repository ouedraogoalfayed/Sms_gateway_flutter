// Classe pour représenter un élément d'historique
class HistoryItem {
  final String id;
  final String senderAddress;
  final String date;
  final List<EndpointResult> endpoints;

  HistoryItem({
    required this.id,
    required this.senderAddress,
    required this.date,
    required this.endpoints,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderAddress': senderAddress,
      'date': date,
      'endpoints': endpoints.map((e) => e.toJson()).toList(),
    };
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      senderAddress: json['senderAddress'],
      date: json['date'],
      endpoints: (json['endpoints'] as List)
          .map((e) => EndpointResult.fromJson(e))
          .toList(),
    );
  }
}

// Classe pour représenter le résultat d'un endpoint
class EndpointResult {
  final String endpointName;
  final String endpointUrl;
  final String status; // 'success', 'error', 'warning'
  final String method;

  EndpointResult({
    required this.endpointName,
    required this.endpointUrl,
    required this.status,
    required this.method,
  });

  Map<String, dynamic> toJson() {
    return {
      'endpointName': endpointName,
      'endpointUrl': endpointUrl,
      'status': status,
      'method': method,
    };
  }

  factory EndpointResult.fromJson(Map<String, dynamic> json) {
    return EndpointResult(
      endpointName: json['endpointName'],
      endpointUrl: json['endpointUrl'],
      status: json['status'],
      method: json['method'],
    );
  }
}

// Classe pour représenter un élément aplati (un SMS avec un endpoint spécifique)
  class FlatHistoryItem {
    final String senderAddress;
    final String date;
    final EndpointResult endpoint;

    FlatHistoryItem({
      required this.senderAddress,
      required this.date,
      required this.endpoint,
    });
  }

  

