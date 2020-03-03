import 'package:flutter/foundation.dart';

class UserSignUpModel {
  final String message;

  UserSignUpModel({
    @required this.message,
  });

  factory UserSignUpModel.fromJson(String json) {
    return UserSignUpModel(
      message: json,
    );
  }
}
