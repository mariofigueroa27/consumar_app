import 'package:flutter/material.dart';

import '../../../models/roro/printer_app/vw_get_count_vehiculos_etiquetados_by_service_order.dart';
import '../../../models/roro/printer_app/vw_printer_app_list_by_id_service_order.dart';
import '../../../services/roro/printer_app/printer_app_service.dart';
import '../../../utils/constants.dart';

class PrinterAppListado extends StatefulWidget {
  const PrinterAppListado({Key? key, required this.idServiceOrder})
      : super(key: key);

  final BigInt idServiceOrder;

  @override
  State<PrinterAppListado> createState() => _PrinterAppListadoState();
}

class _PrinterAppListadoState extends State<PrinterAppListado> {
  PrinterAppService printerAppService = PrinterAppService();

  int cantidadTotal = 0;

  VwGetCountVehiculosEtiquetadosByServiceOrder
      vwGetCountVehiculosEtiquetadosByServiceOrder =
      VwGetCountVehiculosEtiquetadosByServiceOrder();

  List<VwPrinterAppListByIdServiceOrder> vwPrinterAppListByIdServiceOrder = [];

  int vhEtiquetados = 0;

  /*getVwPrinterAppListByIdServiceOrder() async {
    List<VwPrinterAppListByIdServiceOrder> value = await printerAppService
        .getPrinterAppListByIdServiceOrder(widget.idServiceOrder);

    setState(() {
      vwPrinterAppListByIdServiceOrder = value;
      cantidadTotal = vwPrinterAppListByIdServiceOrder.length;
    });
    //print(vwPrinterAppListByIdServiceOrder.length);
  }*/

 /* getCountVehiculosEtiquetadosByServiceOrder() async {
    vwGetCountVehiculosEtiquetadosByServiceOrder = await printerAppService
        .getCountVehiculosEtiquetadosByServiceOrder(widget.idServiceOrder);

    setState(() {
      vhEtiquetados = vwGetCountVehiculosEtiquetadosByServiceOrder
          .numeroVehiculosEtiquetado!;
    });
    //print(vwPrinterAppListByIdServiceOrder.length);
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getVwPrinterAppListByIdServiceOrder();
    //getCountVehiculosEtiquetadosByServiceOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("PRINTER APP STATUS"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Vehiculos Totales: ${cantidadTotal.toString()}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Vehiculos Sin Etiquetar: ${cantidadTotal - vhEtiquetados}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                            "Vehiculos Etiquetados: ${vhEtiquetados.toString()}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dividerThickness: 3,
                      border: TableBorder.symmetric(
                          inside: BorderSide(
                              width: 1, color: Colors.grey.shade200)),
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorAzul),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: kColorAzul),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text("N°"),
                        ),
                        DataColumn(
                          label: Text("Chassis"),
                        ),
                        DataColumn(
                          label: Text("Marca"),
                        ),
                        DataColumn(
                          label: Text("Modelo"),
                        ),
                        DataColumn(
                          label: Text("Detalle"),
                        ),
                        DataColumn(
                          label: Text("Operacion"),
                        ),
                        DataColumn(
                          label: Text("Estado"),
                        ),
                        DataColumn(
                          label: Text("Delete"),
                        ),
                      ],
                      rows: vwPrinterAppListByIdServiceOrder
                          .map(((e) => DataRow(cells: <DataCell>[
                                DataCell(Text(e.idVista.toString())),
                                DataCell(Text(e.chasis!)),
                                DataCell(Text(e.marca!)),
                                DataCell(Text(e.modelo!)),
                                DataCell(Text(e.detalle!)),
                                DataCell(Text(e.operacion!)),
                                DataCell(Text(e.estado!)),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                     /* printerAppService.delecteLogicOperacion(
                                          BigInt.parse(
                                              e.idRoroOperacion.toString()));*/
                                    },
                                  ),
                                ),
                              ])))
                          .toList(),
                    )),
              ],
            ),
          ),
        ));
  }
}
