import 'package:flutter/foundation.dart';

class PeriodoAcademicoModel {
  final String idPeriodo;
  final String anhoPeriodo;
  final String nombre;

  PeriodoAcademicoModel({
    @required this.idPeriodo,
    @required this.anhoPeriodo,
    @required this.nombre,
  });

  factory PeriodoAcademicoModel.fromJson(Map<String, dynamic> json) {
    return PeriodoAcademicoModel(
      idPeriodo: json['id_periodo'] as String,
      anhoPeriodo: json['anho_periodo'] as String,
      nombre: json['nombre'] as String,
    );
  }
}
