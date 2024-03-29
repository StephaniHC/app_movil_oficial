import 'package:app_movil_oficial/bloc/busqueda/busqueda_bloc.dart';
import 'package:app_movil_oficial/bloc/mapa/mapa_bloc.dart';
import 'package:app_movil_oficial/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:app_movil_oficial/pages/loading_page1.dart';
import 'package:app_movil_oficial/routes/routes.dart';
import 'package:app_movil_oficial/services/BottomNavigationBarServices/ui_provider.dart';
import 'package:app_movil_oficial/services/auth_service.dart';
import 'package:app_movil_oficial/services/denuncia_service.dart';
import 'package:app_movil_oficial/services/denuncia_solicitud_service.dart';
import 'package:app_movil_oficial/services/notification_service.dart';
import 'package:app_movil_oficial/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final notification = new NotificationsService();
    notification.initNotifications();
    notification.mensajesStream.listen((data) {
      print('recibiendo notification');
      print(data);

      navigatorKey.currentState
          .pushReplacementNamed('denuncia', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => DenunciaService()),
          ChangeNotifierProvider(create: (_) => DenunciaSolicitudService()),
          ChangeNotifierProvider(create: (_) => SocketService()),
          ChangeNotifierProvider(create: (_) => UiProvider()),
          Provider(create: (_) => NotificationsService()),
          BlocProvider(create: (_) => MiUbicacionBloc()),
          BlocProvider(create: (_) => MapaBloc()),
          BlocProvider(create: (_) => BusquedaBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Denuncias Oficial',
          navigatorKey: navigatorKey,
          // initialRoute: 'register_trabajador',
          home: LoadingPage1(),
          // initialRoute: 'loading1',
          routes: appRoutes,
          theme: ThemeData(primaryColor: Color.fromARGB(255, 32, 217, 148)),
        ));
  }
}
