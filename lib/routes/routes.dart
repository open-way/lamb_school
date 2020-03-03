// import 'package:step5/module/contacts/contact_list_view.dart';
// import 'package:step5/module/events/event_list_view.dart';
// import 'package:step5/module/notes/note_list_view.dart';

import 'package:lamb_school/pages/agenda_page/agenda_page.dart';
import 'package:lamb_school/pages/asistencia_page/asistencia_page.dart';
import 'package:lamb_school/pages/dashboard_page/dashboard_page.dart';
import 'package:lamb_school/pages/estado_cuenta_page/estado_cuenta_page.dart';
import 'package:lamb_school/pages/generate_barcode_page/generate_barcode_page.dart';
import 'package:lamb_school/pages/login_signup_page/login_signup_page.dart';
import 'package:lamb_school/pages/test_https_page/test_https_page.dart';

class Routes {
  static const String dashboard = DashboardPage.routeName;
  static const String login_signup = LoginSignupPage.routeName;
  static const String estado_cuenta = EstadoCuentaPage.routeName;
  static const String asistencia = AsistenciaPage.routeName;
  static const String agenda = AgendaPage.routeName;
  static const String test_https = TestHttpsPage.routeName;
  static const String generate_barcode = GenerateBarcodePage.routeName;
  // static const String events = EventsPage.routeName;
  // static const String notes = NotesPage.routeName;
}
