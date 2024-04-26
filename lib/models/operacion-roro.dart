class OperacionRoro {
  String? id;
  String? puerto;
  String? terminal;
  DateTime? fecha;
  String? muelle;
  String? cliente;
  String? operacion;
  String? bl;
  String? mercaderia;
  String? consignatario;
  String? chassis;
  String? serviceOrderId;
  String? travelId;
  String? vehicleId;

  OperacionRoro({
    this.id,
    this.puerto,
    this.terminal,
    this.fecha,
    this.muelle,
    this.cliente,
    this.operacion,
    this.bl,
    this.mercaderia,
    this.consignatario,
    this.chassis,
    this.serviceOrderId,
    this.travelId,
    this.vehicleId,
  });

  factory OperacionRoro.fromJson(Map<String, dynamic> json) {
    return OperacionRoro(
      id: json['id'],
      puerto: json['puerto'],
      terminal: json['terminal'],
      fecha: DateTime.parse(json['fecha']),
      muelle: json['muelle'],
      cliente: json['cliente'],
      operacion: json['operacion'],
      bl: json['bl'],
      mercaderia: json['mercaderia'],
      consignatario: json['consignatario'],
      chassis: json['chassis'],
      serviceOrderId: json['service_order_id'],
      travelId: json['travel_id'],
      vehicleId: json['vehicle_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'puerto': puerto,
      'terminal': terminal,
      'fecha': fecha!.toIso8601String(),
      'muelle': muelle,
      'cliente': cliente,
      'operacion': operacion,
      'bl': bl,
      'mercaderia': mercaderia,
      'consignatario': consignatario,
      'chassis': chassis,
      'service_order_id': serviceOrderId,
      'travel_id': travelId,
      'vehicle_id': vehicleId,
    };
  }
}