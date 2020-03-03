import 'package:flutter/foundation.dart';

class AnhoModel {
  final String idAnho;

  AnhoModel({
    @required this.idAnho,
  });

  factory AnhoModel.fromJson(Map<String, dynamic> json) {
    return AnhoModel(
      idAnho: json['id_anho'] as String,
    );
  }
}
