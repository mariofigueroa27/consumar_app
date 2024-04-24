class Travel {
  final String id;
  final String travelNumber;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime? registeredAt;
  final String shipId;

  Travel({
    required this.id,
    required this.travelNumber,
    required this.startAt,
    required this.endAt,
    this.registeredAt,
    required this.shipId,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      id: json['id'],
      travelNumber: json['travel_number'],
      startAt: DateTime.parse(json['start_at']),
      endAt: DateTime.parse(json['end_at']),
      registeredAt: json['registered_at'] != null
          ? DateTime.parse(json['registered_at'])
          : null,
      shipId: json['ship_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'travel_number': travelNumber,
      'start_at': startAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
      'registered_at': registeredAt?.toIso8601String(),
      'ship_id': shipId,
    };
  }
}