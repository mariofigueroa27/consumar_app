import 'package:consumar_app/src/roro/printer_app/printer_app_page.dart';
import 'package:consumar_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'controllers/rampa_descarga/rampa_descarga_controller.dart';
import 'src/auth/login_page.dart';
import 'utils/check_internet_connection.dart';

final internetChecker = CheckInternetConnection();

void main() {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  //FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RampaDescargaController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Consumar App',
        /*routes: {
          'login': (_) => LoginPantalla(),
          'vehicles': (_) => VehiculosPantalla(),
          'syncVehicles': (_) => SincronizarVehiculos(),
        },
        initialRoute: 'login',*/

        home:  PrinterApp(jornada: 1, idUsuario: BigInt.parse(1.toString()), idServiceOrder: BigInt.parse(1.toString())),
        builder: EasyLoading.init(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: kColorAzul,
          ),
        ),
      ),
    );
  }
}
