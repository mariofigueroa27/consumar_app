import 'package:consumar_app/models/roro/printer_app/vw_get_count_vehiculos_etiquetados_by_service_order.dart';
import 'package:consumar_app/models/roro/printer_app/vw_printer_app_list_by_id_service_order.dart';
import 'package:consumar_app/services/roro/printer_app/printer_app_service.dart';
import 'package:flutter/material.dart';

class PrinterAppListadoController extends ChangeNotifier {
  PrinterAppService printerAppService = PrinterAppService();

  VwGetCountVehiculosEtiquetadosByServiceOrder
      vwGetCountVehiculosEtiquetadosByServiceOrder =
      VwGetCountVehiculosEtiquetadosByServiceOrder();

  List<VwPrinterAppListByIdServiceOrder> vwPrinterAppListByIdServiceOrder = [];

 /* Future<void> getVwPrinterAppListByIdServiceOrder(
      BigInt idServiceOrder) async {
    vwPrinterAppListByIdServiceOrder = await printerAppService
        .getPrinterAppListByIdServiceOrder(idServiceOrder);

    notifyListeners();
  }*/

 /* Future<void> getCountVehiculosEtiquetadosByServiceOrder(
      BigInt idServiceOrder) async {
    vwGetCountVehiculosEtiquetadosByServiceOrder = await printerAppService
        .getCountVehiculosEtiquetadosByServiceOrder(idServiceOrder);

    notifyListeners();
  }*/
}
