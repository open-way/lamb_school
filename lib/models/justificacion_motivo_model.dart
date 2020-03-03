import 'package:flutter/foundation.dart';

class JustificacionMotivoModel {
  final String idJmotivo;
  final String nombre;
  final String estado;

  JustificacionMotivoModel({
    @required this.idJmotivo,
    @required this.nombre,
    @required this.estado,
  });

  factory JustificacionMotivoModel.fromJson(Map<String, dynamic> json) {
    return JustificacionMotivoModel(
      idJmotivo: json['id_jmotivo'] as String,
      nombre: json['nombre'] as String,
      estado: json['estado'] as String,
    );
  }

}
