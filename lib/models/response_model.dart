import 'package:flutter/widgets.dart';

class ResponseModel {
  final String message;

  ResponseModel({
    @required this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'] as String,
    );
  }
}
