import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lamb_school/pages/agenda_page/agenda_page.dart';
import 'package:lamb_school/pages/asistencia_page/asistencia_page.dart';
import 'package:lamb_school/pages/estado_cuenta_page/estado_cuenta_page.dart';
import 'package:lamb_school/pages/generate_barcode_page/generate_barcode_page.dart';
import 'package:lamb_school/pages/login_signup_page/login_signup_page.dart';
import 'package:lamb_school/pages/dashboard_page/dashboard_page.dart';

import 'package:lamb_school/pages/root_page/root_page.dart';
import 'package:lamb_school/pages/test_https_page/test_https_page.dart';
import 'package:lamb_school/routes/routes.dart';
import 'package:lamb_school/services/auth.service.dart';
import 'package:lamb_school/services/mis-hijos.service.dart';
import 'package:lamb_school/services/test-https.service.dart';
import 'package:lamb_school/theme/lamb_themes.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: LambThemes.light.appBarTheme.color));
    return new MaterialApp(
      title: 'Lamb School',
      debugShowCheckedModeBanner: false,
      theme: LambThemes.light,
      home: new RootPage(
        authService: AuthService(),
        misHijosService: MisHijosService(),
        storage: storage,
      ),
      routes: {
        Routes.dashboard: (context) => DashboardPage(
            // authService: AuthService(),
            storage: storage),
        Routes.estado_cuenta: (context) => EstadoCuentaPage(storage: storage),
        Routes.login_signup: (context) => LoginSignupPage(
              authService: AuthService(),
              misHijosService: MisHijosService(),
              storage: storage,
            ),
        Routes.asistencia: (context) => AsistenciaPage(
            // auth: AuthService(),
            storage: storage),
        Routes.agenda: (context) => AgendaPage(storage: storage),
        Routes.generate_barcode: (context) =>
            GenerateBarcodePage(storage: storage),
        Routes.test_https: (context) => TestHttpsPage(
              storage: storage,
              testHttpsService: TestHttpsService(),
            ),
      },
    );
  }
}
