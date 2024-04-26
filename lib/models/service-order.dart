class ServiceOrder {
  String? id;
  String? serviceNumber;
  DateTime? registeredAt;
  String? operacion;

  ServiceOrder({
    this.id,
    this.serviceNumber,
    this.registeredAt,
    this.operacion,
  });

  factory ServiceOrder.fromJson(Map<String, dynamic> json) {
    return ServiceOrder(
      id: json['id'],
      serviceNumber: json['service_number'],
      registeredAt: DateTime.parse(json['registered_at']),
      operacion: json['Operacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_number': serviceNumber,
      'registered_at': registeredAt!.toIso8601String(),
      'Operacion': operacion,
    };
  }
}