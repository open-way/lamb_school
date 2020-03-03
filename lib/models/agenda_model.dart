import 'package:flutter/foundation.dart';

class AgendaModel {
  final String idActividad;
  final String nivelActividad;
  final String fechaInicio;
  final String fechaFinal;
  final String nombre;
  final String descripcion;
  final String nivel;
  final String grado;
  final String seccion;
  final String curso;
  final String categoriaNombre;
  final String categoriaColor;

  AgendaModel({
    @required this.idActividad,
    @required this.nivelActividad,
    @required this.fechaInicio,
    @required this.fechaFinal,
    @required this.nombre,
    @required this.descripcion,
    @required this.nivel,
    @required this.grado,
    @required this.seccion,
    @required this.curso,
    @required this.categoriaNombre,
    @required this.categoriaColor,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel(
      idActividad: json['id_actividad'] as String,
      nivelActividad: json['nivel_actividad'] as String,
      fechaInicio: json['fecha_inicio'] as String,
      fechaFinal: json['fecha_final'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      nivel: json['nivel'] as String,
      grado: json['grado'] as String,
      seccion: json['seccion'] as String,
      curso: json['curso'] as String,
      categoriaNombre: json['categoria_nombre'] as String,
      categoriaColor: json['categoria_color'] as String,
    );
  }
}
