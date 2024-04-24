//import 'package:consumar_app/src/roro/autoreport/autoreport_list_page.dart';
import 'package:consumar_app/models/Travel.dart';
import 'package:consumar_app/models/ship.dart';
import 'package:consumar_app/models/vehicle.dart';
import 'package:consumar_app/src/roro/printer_app/reetiquetado_print_page.dart';
//import 'package:consumar_app/src/roro/printer_app/qr_pdf_reetiquetado_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/roro/printer_app/create_sql_lite_printer_app.dart';
import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';
import '../../../services/roro/printer_app/printer_app_service.dart';
import '../../../utils/check_internet_connection.dart';
import '../../../utils/connection_status_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/roro/sqliteBD/db_printer_app.dart';


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

List<InsertPrinterAppPendientes> allDR = getPrinterAppPendientes;

List<CreateSqlLitePrinterApp> createSqlLitePrinterApp = [];

List<CreateSqlLitePrinterApp> allDREtiqutado = createSqlLitePrinterApp;

List<Ship> shipList = [];

List<Travel> travelList = [];

List<Vehicle> vehicleList = [];

String idShip = "";

String idTravel = "";

class _PrinterAppState extends State<PrinterApp>
    with SingleTickerProviderStateMixin {
  final controllerSearchChasis = TextEditingController();

  final controllerSearchChasisEtiquetado = TextEditingController();
  DbPrinterApp dbPrinterApp = DbPrinterApp();

  PrinterAppService printerAppService = PrinterAppService();

    Ship? _selectedShip; // Variable para almacenar el barco seleccionado
    Travel? _selectedTravel; // Variable para almacenar el barco seleccionado

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaBarcos() async {
    List<Ship> value = await printerAppService.getShips();

    setState(() {
      shipList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaViaje() async {
    List<Travel> value = await printerAppService.getTravels(idShip);

    setState(() {
      travelList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListVehiculos() async {
    List<Vehicle> value = await printerAppService.getVehicles(idTravel);

    setState(() {
      vehicleList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaPrinterAppPendiente() async {
    List<InsertPrinterAppPendientes> value =
        await dbPrinterApp.listPrinterPendientesData();

    setState(() {
      getPrinterAppPendientes = value;
      allDR = getPrinterAppPendientes;
    });
  }

  //Metodo para obtener la lista en local de los Vehiculos Etiquetados
  obtenerListadoPrinterAppEtiquetado() async {
    createSqlLitePrinterApp =
        await dbPrinterApp.getSqlLitePrinterAppEtiquetados();

    setState(() {
      allDREtiqutado = createSqlLitePrinterApp;
    });
  }




  //Metodo para hacer la carga general de vehiculos etiquetados a la base de datos (roro_printer_etiquetado)
  /* cargarListaGeneralPrinterAppEtiquetados() {
    printerAppService.createPrinterAppList(createSqlLitePrinterApp);
  }*/

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabIndex);
    // TODO: implement initState
    super.initState();
    cargarListaBarcos();
    cargarListaPrinterAppPendiente();
    obtenerListadoPrinterAppEtiquetado();
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
                              getPrinterAppPendientes.length.toString(),
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
                            createSqlLitePrinterApp.length.toString(),
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
                      Card(
                          color: Colors.black,
                          child: ListTile(
                            leading: const Icon(Icons.search),
                            title: TextField(
                                controller: controllerSearchChasis,
                                decoration: const InputDecoration(
                                    hintText: 'Buscar Placas',
                                    hintStyle: TextStyle(
                                      color: Colors
                                          .white, // Color medio gris para el texto de sugerencia
                                    ),
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
                          )),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                           // dividerThickness: 3,
                           /* border: TableBorder.symmetric(
                                inside: BorderSide(
                                    width: 1, color: Colors.grey.shade200)),*/
                         /*   decoration: BoxDecoration(
                              border: Border.all(color: colors),
                              borderRadius: BorderRadius.circular(10),
                            ),*/
                           /* headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),*/
                          /*  dataRowColor: MaterialStateProperty.resolveWith(
                                _getDataRowColor),*/
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(""),
                              ),
                              DataColumn(
                                label: Text(""),
                              ),
                            ],
                            rows: vehicleList
                                .map(((e) => DataRow(
                                        onLongPress: () {
                                          /*Navigator.push(
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
                                                          idPendientes: e
                                                              .idPrinterAppPendientes!)));*/
                                        },
                                        cells: <DataCell>[
                                          DataCell(Text(e.chassis.toString(),style: TextStyle(color: Colors.white))),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () {
                                                // Aquí puedes manejar la acción de etiquetar
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.blue),
                                                shape: MaterialStateProperty
                                                    .all<OutlinedBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                          ),
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
                    BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status != ConnectionStatus.online,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 60,
                                color: Colors.red,
                                child: const Row(
                                  children: [
                                    Icon(Icons.wifi_off),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("SIN CONEXIÓN A INTERNET")
                                  ],
                                ),
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
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 60,
                                color: Colors.green,
                                child: const Row(
                                  children: [
                                    Icon(Icons.cell_wifi),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("CON CONEXIÓN A INTERNET")
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
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
                    )),
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
                          /* headingRowColor: MaterialStateColor.resolveWith(
                            (states) {
                              return kColorAzul;
                            },
                          ), */
                          dataRowColor: MaterialStateProperty.resolveWith(
                              _getDataRowColor),
                          /* dataRowColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) =>
                            states.contains(MaterialState.selected)
                                ? kColorCeleste
                                : Color.fromARGB(100, 215, 217, 219)), */
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text("Chassis"),
                            ),
                            DataColumn(
                              label: Text("Estado"),
                            ),
                          ],
                          rows: allDREtiqutado
                              .map(((e) => DataRow(cells: <DataCell>[
                                    DataCell(
                                        Text(e.idPrEtiquetados.toString())),
                                    DataCell(Text(e.chasis!)),
                                    DataCell(Text(e.marca!)),
                                    DataCell(Text(e.modelo!)),
                                    DataCell(Text(e.detalle!)),
                                    DataCell(Text(e.estado!)),
                                    DataCell(IconButton(
                                      icon: const Icon(
                                        Icons.qr_code,
                                      ),
                                      onPressed: () {
                                        dialogoReetiquetado(context, e);
                                      },
                                    ))
                                  ])))
                              .toList(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocProvider(
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
                                  //cargarListaGeneralPrinterAppEtiquetados();
                                  await dbPrinterApp
                                      .clearTablePrinterAppEtiquetados();
                                  setState(() {
                                    cargarListaPrinterAppPendiente();
                                    allDR;
                                    obtenerListadoPrinterAppEtiquetado();
                                    createSqlLitePrinterApp.clear();
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
                cargarListaPrinterAppPendiente();
                obtenerListadoPrinterAppEtiquetado();
                setState(() {
                  getPrinterAppPendientes;
                  createSqlLitePrinterApp;
                });
              },
              backgroundColor: kColorNaranja,
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(
              height: 10,
            ),
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
                                DropdownButton<Ship>(
                                  isExpanded: true,
                                  hint: Text('Seleccione Nave'),
                                  value:
                                      _selectedShip, // Establece el valor seleccionado
                                  // Rellena los items del menú desplegable con las naves obtenidas
                                  items: shipList.map((Ship ship) {
                                    return DropdownMenuItem<Ship>(
                                      value: ship,
                                      child: Text(ship.name),
                                    );
                                  }).toList(),
                                  onChanged: (Ship? newValue) {
                                    setState(() {
                                      _selectedShip =
                                          newValue; // Actualiza el barco seleccionado
                                    });
                                    // Aquí puedes manejar el cambio de selección de la nave
                                    // Por ejemplo, puedes llamar a otro método y pasar el ID del barco seleccionado
                                    if (_selectedShip != null) {
                                     setState(() {
                                      idShip =
                                          newValue!.id; // Actualiza el barco seleccionado
                                    });
                                    }
                                    cargarListaViaje();
                                  },
                                ),
                                SizedBox(height: 10),
                                DropdownButton<Travel>(
                                  isExpanded: true,
                                  hint: Text('Seleccione Viaje'),
                                  value:
                                      _selectedTravel, // Establece el valor seleccionado
                                  // Rellena los items del menú desplegable con las naves obtenidas
                                  items: travelList.map((Travel travel) {
                                    return DropdownMenuItem<Travel>(
                                      value: travel,
                                      child: Text(travel.travelNumber),
                                    );
                                  }).toList(),
                                  onChanged: (Travel? newValue) {
                                    setState(() {
                                      _selectedTravel =
                                          newValue; // Actualiza el barco seleccionado
                                    });
                                    // Aquí puedes manejar el cambio de selección de la nave
                                    // Por ejemplo, puedes llamar a otro método y pasar el ID del barco seleccionado
                                   if (_selectedTravel != null) {
                                     setState(() {
                                      idTravel =
                                          newValue!.id; // Actualiza el barco seleccionado
                                    });
                                    }
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
    final suggestion = getPrinterAppPendientes.where((drList) {
      final listDR = drList.chasis!.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDR = suggestion);
    setState(() {
      controllerSearchChasis;
      // controllerSearchChasisEtiquetado;
    });
  }

  void searchMarca(String query) {
    final suggestion = getPrinterAppPendientes.where((drList) {
      final listDR = drList.marca!.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDR = suggestion);
  }

  void searchModelo(String query) {
    final suggestion = getPrinterAppPendientes.where((drList) {
      final listDR = drList.modelo!.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDR = suggestion);
  }

  void searchChassisEtiquetado(String query) {
    final suggestion = createSqlLitePrinterApp.where((drList) {
      final listDR = drList.chasis!.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDREtiqutado = suggestion);
  }

  void searchMarcaEtiquetado(String query) {
    final suggestion = createSqlLitePrinterApp.where((drList) {
      final listDR = drList.marca!.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDREtiqutado = suggestion);
  }

  void searchModeloEtiquetado(String query) {
    final suggestion = createSqlLitePrinterApp.where((drList) {
      final listDR = drList.modelo!.toLowerCase();
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
