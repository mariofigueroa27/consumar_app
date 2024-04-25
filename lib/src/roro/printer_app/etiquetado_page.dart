import 'package:barcode_widget/barcode_widget.dart';
import 'package:consumar_app/src/roro/printer_app/print_page.dart';

//import 'package:consumar_app/src/roro/printer_app/qr_pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';
import '../../../utils/constants.dart';
import '../../../utils/roro/sqliteBD/db_printer_app.dart';

class EtiquetadoPrinterApp extends StatefulWidget {
  const EtiquetadoPrinterApp(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder,
      required this.idPendientes,
      required this.chassis})
      : super(key: key);

  final int jornada;
  final BigInt idUsuario;
  final BigInt idServiceOrder;
  final int idPendientes;
  final String chassis;

  @override
  State<EtiquetadoPrinterApp> createState() => _EtiquetadoPrinterAppState();
}

class _EtiquetadoPrinterAppState extends State<EtiquetadoPrinterApp> {
  final qrController = TextEditingController();
  final chasisController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final detalleController = TextEditingController();

  final codigoQr = imageFromAssetBundle('assets/images/qrlogo.png');

  DbPrinterApp dbPrinterApp = DbPrinterApp();
  InsertPrinterAppPendientes insertPrinterAppPendientes =
      InsertPrinterAppPendientes();

  /* getPendienteByID() async {
    chasisController.text = widget.chassis;
  }*/

  //Metodo para etiquetar los vehiculos

  /*createPrinterAppEtiquetado() {
    dbPrinterApp.createPrinterAppEtiquetado(CreateSqlLitePrinterApp(
        jornada: widget.jornada,
        idServiceOrder: int.parse(widget.idServiceOrder.toString()),
        idUsuarios: int.parse(widget.idUsuario.toString()),
        idVehicle: int.parse(qrController.text),
        chasis: chasisController.text,
        detalle: detalleController.text,
        estado: "etiquetado",
        marca: marcaController.text,
        modelo: modeloController.text));
    insertPrinterAppPendientes.estado = "etiquetado";
    dbPrinterApp.update(insertPrinterAppPendientes);
    //se setea nuevamente para obtener lista actualizada
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chasisController.text = widget.chassis;
    String textoQr = widget.idPendientes.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "ETIQUETADO",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: textoQr,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: kColorAzul,
                ),
                labelText: 'Chasis',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: chasisController,
              style: TextStyle(
                color: kColorAzul,
                fontSize: 20.0,
              ),
              enabled: false,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minWidth: double.infinity,
              height: 50.0,
              color: kColorNaranja,
              onPressed: () {
                //createPrinterAppEtiquetado();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrintPage(widget.idPendientes)));
                /*     Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrRoroPDF(
                            idVehicle:
                                insertPrinterAppPendientes.idVehiculo!))); */
              },
              child: const Text(
                "ETIQUETAR",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
