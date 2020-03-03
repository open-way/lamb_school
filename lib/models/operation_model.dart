import 'package:flutter/foundation.dart';

class OperationTotalModel {
  final String total;

  OperationTotalModel({
    @required this.total,
  });

  factory OperationTotalModel.fromJson(Map<String, dynamic> json) {
    return OperationTotalModel(
      total: json['total'] as String,
    );
  }
}

class OperationModel {
  final String fecha;
  final String serie;
  final String numero;
  final String glosa;
  final String total;

  OperationModel({
    @required this.fecha,
    @required this.serie,
    @required this.numero,
    @required this.glosa,
    @required this.total,
  });

  factory OperationModel.fromJson(Map<String, dynamic> json) {
    return OperationModel(
      fecha: json['fecha'] as String,
      serie: json['serie'] as String,
      numero: json['numero'] as String,
      glosa: json['glosa'] as String,
      total: json['total'] as String,
    );
  }
}

class EstadoCuentaModel {
  final List<dynamic> movements;
  final OperationTotalModel movementsTotal;

  EstadoCuentaModel({
    @required this.movements,
    @required this.movementsTotal,
  });

  factory EstadoCuentaModel.fromJson(Map<String, dynamic> json) {
    return EstadoCuentaModel(
      movements: json['movements'] as List<dynamic>,
      // movements: json['movements'].cast<Map<String, dynamic>>(),
      // movements: json['movements'] as List<OperationModel>,
      // movementsTotal: json['movements_total'] as OperationTotalModel,
      movementsTotal: new OperationTotalModel.fromJson(json['movements_total']),
    );
  }
}
