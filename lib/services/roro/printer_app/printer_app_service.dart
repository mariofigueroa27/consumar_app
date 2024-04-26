import 'dart:convert';

import 'package:consumar_app/models/Travel.dart';
import 'package:consumar_app/models/operacion-roro.dart';
import 'package:consumar_app/models/service-order.dart';
import 'package:consumar_app/models/ship.dart';
import 'package:http/http.dart' as http;

class PrinterAppService {
  static const String baseUrl = 'https://newbackprinter.azurewebsites.net/api';

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

  // Método para obtener la lista de service order espaciales
  Future<List<ServiceOrder>> getServiceOrder() async {
    final response = await http.get(Uri.parse('$baseUrl/service-orders'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((serviceorderJson) => ServiceOrder.fromJson(serviceorderJson))
          .toList();
    } else {
      throw Exception('Failed to load Service Order');
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
  Future<List<OperacionRoro>> getVehiclesOperacion(
      String idTravel, String serviceOrderId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$idTravel/$serviceOrderId/vehicles'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((operacionJson) => OperacionRoro.fromJson(operacionJson))
          .toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  Future<void> actualizarVehiculos(
      List<int> ids, int serviceOrderId, int travelId) async {
    final url = Uri.parse(
        'https://newbackprinter.azurewebsites.net/api/actualizar-vehiculos');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'ids': ids,
      'service_order_id': serviceOrderId,
      'travel_id': travelId,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print("service id $serviceOrderId");
        print("travel id $travelId");
        print(" ide  ${ids[0]}");
        print("cuantos ides mando ${ids.length}");

        print('Registros actualizados correctamente');
      } else {
        print('Error al actualizar los registros: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }
}
