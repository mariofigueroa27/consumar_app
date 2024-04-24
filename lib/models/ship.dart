class Ship {
  final String id;
  final String name;
  final DateTime? registeredAt;
  final String? operacion;
  final String? operation;

  Ship({
    required this.id,
    required this.name,
    this.registeredAt,
    this.operacion,
    this.operation,
  });

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
      id: json['id'],
      name: json['name'],
      registeredAt: json['registered_at'] != null
          ? DateTime.parse(json['registered_at'])
          : null,
      operacion: json['Operacion'],
      operation: json['operation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registered_at': registeredAt?.toIso8601String(),
      'Operacion': operacion,
      'operation': operation,
    };
  }
}