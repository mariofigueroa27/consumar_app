import 'dart:convert';

import 'package:consumar_app/models/Travel.dart';
import 'package:consumar_app/models/ship.dart';
import 'package:consumar_app/models/vehicle.dart';
import 'package:http/http.dart' as http;

class PrinterAppService {
  static const String baseUrl = 'http://localhost:3000/api';

  // Método para obtener la lista de naves espaciales
  Future<List<Ship>> getShips() async {
    final response = await http.get(Uri.parse('$baseUrl/ships'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((shipJson) => Ship.fromJson(shipJson)).toList();
    } else {
      throw Exception('Failed to load ships');
    }
  }

  // Método para obtener los viajes de una nave espacial específica
  Future<List<Travel>> getTravels(String idShip) async {
    final response = await http.get(Uri.parse('$baseUrl/$idShip/travels'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((travelJson) => Travel.fromJson(travelJson)).toList();
    } else {
      throw Exception('Failed to load travels');
    }
  }

  // Método para obtener los vehículos de un viaje específico
  Future<List<Vehicle>> getVehicles(String idTravel) async {
    final response = await http.get(Uri.parse('$baseUrl/$idTravel/vehicles'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((vehicleJson) => Vehicle.fromJson(vehicleJson)).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }
}
