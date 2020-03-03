import 'package:flutter/foundation.dart';

class DashboardModel {
  final List<dynamic> estadoCuentaResumen;
  final String eventos;
  final Map<String, dynamic> asistencias;

  DashboardModel({
    @required this.estadoCuentaResumen,
    @required this.eventos,
    @required this.asistencias,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      estadoCuentaResumen: json['estado_cuenta_resumen'] as List<dynamic>,
      eventos: json['eventos'] as String,
      asistencias: json['asistencias'] as Map<String, dynamic>,
    );
  }
}
