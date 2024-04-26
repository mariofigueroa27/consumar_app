//import 'package:consumar_app/src/roro/autoreport/autoreport_list_page.dart';
import 'package:consumar_app/models/Travel.dart';
import 'package:consumar_app/models/service-order.dart';
import 'package:consumar_app/models/ship.dart';
import 'package:consumar_app/models/vehicle.dart';
import 'package:consumar_app/src/roro/printer_app/etiquetado_page.dart';
import 'package:consumar_app/src/roro/printer_app/reetiquetado_print_page.dart';
//import 'package:consumar_app/src/roro/printer_app/qr_pdf_reetiquetado_page.dart';
import 'package:flutter/material.dart';
import '../../../models/operacion-roro.dart';
import '../../../models/roro/printer_app/create_sql_lite_printer_app.dart';
import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';
import '../../../services/roro/printer_app/printer_app_service.dart';
import '../../../utils/constants.dart';
//import '../../../utils/roro/sqliteBD/db_printer_app.dart';

class PrinterApp extends StatefulWidget {
  const PrinterApp(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final BigInt idUsuario;
  final BigInt idServiceOrder;

  @override
  State<PrinterApp> createState() => _PrinterAppState();
}

late TabController _tabController;

List<InsertPrinterAppPendientes> getPrinterAppPendientes = [];

List<Vehicle> vehicleList = [];

List<OperacionRoro> operacionList = [];

List<Vehicle> vehicleEtiquetadoList = [];

List<Vehicle> allDR = vehicleList;

List<Vehicle> allDREtiqutado = vehicleEtiquetadoList;

List<Ship> shipList = [];

List<ServiceOrder> serviceOrderList = [];

List<Travel> travelList = [];

String idShip = "";

String idTravel = "";

String idS0 = "";

class _PrinterAppState extends State<PrinterApp>
    with SingleTickerProviderStateMixin {
  final controllerSearchChasis = TextEditingController();

  final controllerSearchChasisEtiquetado = TextEditingController();
  // DbPrinterApp dbPrinterApp = DbPrinterApp();

  PrinterAppService printerAppService = PrinterAppService();

  ServiceOrder? _selectedS0;
  Ship? _selectedShip; // Variable para almacenar el barco seleccionado
  Travel? _selectedTravel; // Variable para almacenar el barco seleccionado

  /*//Metodo para obtener la lista en local de los Vehiculos Etiquetados
  obtenerListadoPrinterAppEtiquetado() async {
    createSqlLitePrinterApp =
        await dbPrinterApp.getSqlLitePrinterAppEtiquetados();

    setState(() {
      allDREtiqutado = createSqlLitePrinterApp;
    });
  }
  */
  //Metodo para hacer la carga general de vehiculos etiquetados a la base de datos (roro_printer_etiquetado)
  /* cargarListaGeneralPrinterAppEtiquetados() {
    printerAppService.createPrinterAppList(createSqlLitePrinterApp);
  }*/

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaBarcos() async {
    List<Ship> value = await printerAppService.getShips();

    setState(() {
      shipList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaSO() async {
    List<ServiceOrder> value = await printerAppService.getServiceOrder();

    setState(() {
      serviceOrderList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaViaje() async {
    List<Travel> value = await printerAppService.getTravels(idShip);

    setState(() {
      travelList = value;
    });
    print(travelList.length);
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListVehiculos() async {
    List<OperacionRoro> value = await printerAppService.getVehiclesOperacion(idTravel,idS0);

    setState(() {
      operacionList = value;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabIndex);
    // TODO: implement initState
    super.initState();
    cargarListaBarcos();
    cargarListaSO();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Vehículos",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(255, 223, 216, 216),
              controller: _tabController,
              //onTap: (value) => searchChassis,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('PENDIENTES'),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 20,
                          decoration: const BoxDecoration(
                              //border: Border.all(color: Colors.black),
                              color: Colors.orange),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              operacionList.length.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                    ],
                  ),
                ),
                Tab(
                    child: Row(
                  children: [
                    const Text('ETIQUETADOS'),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 20,
                        decoration: const BoxDecoration(
                            //border: Border.all(color: Colors.black),
                            color: Colors.orange),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            vehicleEtiquetadoList.length.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ],
                )),
              ]),
        ),
        body: Container(
          color: kColorAzul2,
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Column(children: [
                      /*Card(
                          child: ListTile(
                        leading: const Icon(Icons.search),
                        title: TextField(
                            controller: controllerSearchChasis,
                            decoration: const InputDecoration(
                                hintText: 'Buscar Placas',
                                border: InputBorder.none),
                            onChanged: ((value) {
                              searchChassis(value);
                              searchChassisEtiquetado(value);
                            })),
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              controllerSearchChasis.clear();
                              searchChassis;
                            });
                          },
                        ),
                      )),*/
                      const SizedBox(height: 20),
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
                            dataRowColor: MaterialStateProperty.resolveWith(
                                _getDataRowColor),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text("Chassis"),
                              ),
                              DataColumn(
                                label: Text("Estado"),
                              ),
                            ],
                            rows: operacionList
                                .map(((e) => DataRow(cells: <DataCell>[
                                      DataCell(
                                        Text(
                                          e.chassis!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      //DataCell(Text(e.estado!)),
                                      DataCell(
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EtiquetadoPrinterApp(
                                                          jornada:
                                                              widget.jornada,
                                                          idUsuario:
                                                              widget.idUsuario,
                                                          idServiceOrder: widget
                                                              .idServiceOrder,
                                                          idPendientes:
                                                              int.parse(e.id!),
                                                          chassis: e.chassis!,
                                                        )));
                                            OperacionRoro selectedVehicle =
                                                operacionList.firstWhere(
                                                    (vehicle) =>
                                                        vehicle.id == e.id);

                                            Vehicle simplifiedVehicle = Vehicle(
                                                id: selectedVehicle.vehicleId!,
                                                chassis:
                                                    selectedVehicle.chassis!,
                                                operation: '',
                                                tradeMark: '',
                                                detail: '',
                                                travelId: '',
                                                serviceOrderId: '');

                                            vehicleEtiquetadoList
                                                .add(simplifiedVehicle);

                                            operacionList.removeWhere((vehicle) =>
                                                vehicle.id == e.id);
                                            setState(() {
                                              operacionList;
                                              vehicleEtiquetadoList;
                                            });
                                            // Aquí puedes manejar la acción de etiquetar
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(kColorCeleste2),
                                            shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10.0), // Define el radio del borde
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'Etiquetar',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ])))
                                .toList(),
                          )),
                    ]),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    /*Card(
                        child: ListTile(
                      leading: const Icon(Icons.search),
                      title: TextField(
                          controller: controllerSearchChasis,
                          decoration: const InputDecoration(
                              hintText: 'Buscar Chasis Etiquetado',
                              border: InputBorder.none),
                          onChanged: ((value) {
                            searchChassis(value);
                            searchChassisEtiquetado(value);
                          })),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            controllerSearchChasis.clear();
                            searchChassisEtiquetado;
                          });
                        },
                      ),
                    )),*/
                    const SizedBox(height: 20),
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
                          dataRowColor: MaterialStateProperty.resolveWith(
                              _getDataRowColor),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text("Chassis"),
                            ),
                            DataColumn(
                              label: Text("Estado"),
                            ),
                          ],
                          rows: vehicleEtiquetadoList
                              .map(((e) => DataRow(cells: <DataCell>[
                                    DataCell(
                                      Text(
                                        e.chassis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    //DataCell(Text(e.estado!)),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  kColorNaranja),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Define el radio del borde
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Etiquetado',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ])))
                              .toList(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    /*BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status != ConnectionStatus.online,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.red.shade900,
                                          size: 50,
                                        ),
                                        Text(
                                          "ATENCIÓN: ES NECESARIO TENER CONEXIÓN A INTERNET PARA PODER CARGAR DATOS",
                                          style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status == ConnectionStatus.online,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minWidth: double.infinity,
                                height: 50.0,
                                color: kColorNaranja,
                                onPressed: () async {
                                  List<int> idList = vehicleEtiquetadoList
                                      .map<int>(
                                          (vehicle) => int.parse(vehicle.id))
                                      .toList();

                                  await printerAppService
                                      .actualizarVehiculos(idList);

                                  //cargarListaGeneralPrinterAppEtiquetados();
                                  /*  await dbPrinterApp
                                      .clearTablePrinterAppEtiquetados();*/
                                  setState(() {
                                    vehicleEtiquetadoList.clear();
                                    idList.clear();
                                  });
                                },
                                child: const Text(
                                  "CARGAR LISTA",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5),
                                ),
                              ));
                        },
                      ),
                    ),*/
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minWidth: double.infinity,
                      height: 50.0,
                      color: kColorNaranja,
                      onPressed: () async {
                        List<int> idList = vehicleEtiquetadoList
                            .map<int>((vehicle) => int.parse(vehicle.id))
                            .toList();
                        print(idList.length);
                        await printerAppService.actualizarVehiculos(idList,int.parse(idS0),int.parse(idTravel));

                        //cargarListaGeneralPrinterAppEtiquetados();
                        /*  await dbPrinterApp
                                      .clearTablePrinterAppEtiquetados();*/
                        setState(() {
                          vehicleEtiquetadoList.clear();
                          idList.clear();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '¡La actualización se realizó correctamente!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text(
                        "CARGAR LISTA",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: Text(
                            "Sincronizar Vehiculos",
                            textAlign: TextAlign.center,
                          ),
                          content: Container(
                            width: double.maxFinite,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Seleccione una opción:"),
                                SizedBox(height: 10),
                                DropdownButton<ServiceOrder>(
                                  isExpanded: true,
                                  hint: Text('Seleccione Orden Servicio'),
                                  value: _selectedS0,
                                  items:
                                      serviceOrderList.map((ServiceOrder so) {
                                    return DropdownMenuItem<ServiceOrder>(
                                      value: so,
                                      child: Text(so.serviceNumber!),
                                    );
                                  }).toList(),
                                  onChanged: (ServiceOrder? newValue) async {
                                    setState(() {
                                      _selectedS0 = newValue;
                                      idS0 = newValue!.id!;
                                      print(idS0);
                                    });

                                    setState(() {});
                                    // Cargamos la lista de viajes después de seleccionar un barco
                                  },
                                ),
                                SizedBox(height: 10),
                                DropdownButton<Ship>(
                                  isExpanded: true,
                                  hint: Text('Seleccione Nave'),
                                  value: _selectedShip,
                                  items: shipList.map((Ship ship) {
                                    return DropdownMenuItem<Ship>(
                                      value: ship,
                                      child: Text(ship.name),
                                    );
                                  }).toList(),
                                  onChanged: (Ship? newValue) async {
                                    setState(() {
                                      _selectedShip = newValue;
                                      idShip = newValue!.id;
                                      print(idShip);
                                    });
                                    await cargarListaViaje();
                                    // Llamamos a setState para forzar la reconstrucción del diálogo
                                    setState(() {});
                                    // Cargamos la lista de viajes después de seleccionar un barco
                                  },
                                ),
                                SizedBox(height: 10),
                                DropdownButton<Travel>(
                                  isExpanded: true,
                                  hint: Text('Seleccione Viaje'),
                                  value: _selectedTravel,
                                  items: travelList.map((Travel travel) {
                                    return DropdownMenuItem<Travel>(
                                      value: travel,
                                      child: Text(travel.travelNumber),
                                    );
                                  }).toList(),
                                  onChanged: (Travel? newValue) {
                                    setState(() {
                                      _selectedTravel = newValue;
                                      idTravel = newValue!.id;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Aquí puedes manejar la acción de sincronización
                                cargarListVehiculos();
                                Navigator.of(context).pop();
                              },
                              child: Text('Sincronizar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.cloud_sync),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };

    if (states.any(interactiveStates.contains)) {
      return kColorCeleste;
    }
    //return Colors.green; // Use the default value.
    return Colors.transparent;
  }

  void searchChassis(String query) {
    final suggestion = vehicleList.where((drList) {
      final listDR = drList.chassis.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDR = suggestion);
    setState(() {
      controllerSearchChasis;
      // controllerSearchChasisEtiquetado;
    });
  }

  void searchChassisEtiquetado(String query) {
    final suggestion = vehicleEtiquetadoList.where((drList) {
      final listDR = drList.chassis.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDREtiqutado = suggestion);
  }

  dialogoReetiquetado(
      BuildContext context, CreateSqlLitePrinterApp allDREtiqutado) async {
    await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
                //insetPadding: EdgeInsets.all(100),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        /*  Icon(
                          Icons.warning,
                          color: Colors.red.shade900,
                          size: 100,
                        ), */
                        /* Text(
                          "ATENCIÓN ",
                          style: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ), */
                        Text(
                          "¿DESEA REETIQUETAR ESTE VEHICULO?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReetiquetadoPrintPage(
                                                allDREtiqutado.idVehicle!)));
                                /*    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            QrPdfReetiquetadoPage(
                                              idVehicle:
                                                  allDREtiqutado.idVehicle!,
                                            ))); */
                                /*   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PrintPage(
                                            allDREtiqutado.idVehicle!))); */
                              },
                              child: const Text(
                                "ACEPTAR",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "CANCELAR",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ]));
  }
}
