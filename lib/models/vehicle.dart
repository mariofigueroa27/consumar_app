class Vehicle {
  final String id;
  final String chassis;
  final String operation;
  final String tradeMark;
  final String detail;
  final DateTime? labelledDate;
  final DateTime? registeredAt;
  final String travelId;
  final String? userId;
  final String serviceOrderId;

  Vehicle({
    required this.id,
    required this.chassis,
    required this.operation,
    required this.tradeMark,
    required this.detail,
    this.labelledDate,
    this.registeredAt,
    required this.travelId,
    this.userId,
    required this.serviceOrderId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      chassis: json['chassis'],
      operation: json['operation'],
      tradeMark: json['trade_mark'],
      detail: json['detail'],
      labelledDate: json['labelled_date'] != null
          ? DateTime.parse(json['labelled_date'])
          : null,
      registeredAt: json['registered_at'] != null
          ? DateTime.parse(json['registered_at'])
          : null,
      travelId: json['travel_id'],
      userId: json['user_id'],
      serviceOrderId: json['service_order_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chassis': chassis,
      'operation': operation,
      'trade_mark': tradeMark,
      'detail': detail,
      'labelled_date': labelledDate?.toIso8601String(),
      'registered_at': registeredAt?.toIso8601String(),
      'travel_id': travelId,
      'user_id': userId,
      'service_order_id': serviceOrderId,
    };
  }
}