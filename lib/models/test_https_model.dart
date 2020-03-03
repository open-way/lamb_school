import 'package:flutter/foundation.dart';

class TestHttpsModel {
  final String email;

  TestHttpsModel({
    @required this.email,
  });

  factory TestHttpsModel.fromJson(Map<String, dynamic> json) {
    return TestHttpsModel(
      email: json['email'] as String,
    );
  }
}
