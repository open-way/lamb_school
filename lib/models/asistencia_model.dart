import 'package:flutter/foundation.dart';

class AsistenciaModel {
  final String idAsistencia;
  final String periodoNombre;
  final String fechaRegistro;
  final String estadoNombre;
  final String estadoColor;
  final String responsable;
  final String puerta;
  final String idJustificacion;
  final String justificacionEstado;
  final String justificacionMotivo;
  final String justificacionDescripcion;

  AsistenciaModel({
    @required this.idAsistencia,
    @required this.periodoNombre,
    @required this.fechaRegistro,
    @required this.estadoNombre,
    @required this.estadoColor,
    @required this.responsable,
    @required this.puerta,
    @required this.idJustificacion,
    @required this.justificacionEstado,
    @required this.justificacionMotivo,
    @required this.justificacionDescripcion,
  });

  factory AsistenciaModel.fromJson(Map<String, dynamic> json) {
    return AsistenciaModel(
      idAsistencia: json['id_asistencia'] as String,
      periodoNombre: json['periodo_nombre'] as String,
      fechaRegistro: json['fecha_registro'] as String,
      estadoNombre: json['estado_nombre'] as String,
      estadoColor: json['estado_color'] as String,
      responsable: json['responsable'] as String,
      puerta: json['puerta'] as String,
      idJustificacion: json['id_justificacion'] as String,
      justificacionEstado: json['justificacion_estado'] as String,
      justificacionMotivo: json['justificacion_motivo'] as String,
      justificacionDescripcion: json['justificacion_descripcion'] as String,
    );
  }
}
