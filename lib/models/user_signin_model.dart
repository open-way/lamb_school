import 'package:flutter/foundation.dart';

class UserSignInModel {
  final String token;
  final int idPersona;
  final String fullname;
  final String accessToken;
  final String imagenUrl;

  final String oauthFullname;
  final String oauthEmail;


  UserSignInModel({
    @required this.token,
    @required this.idPersona,
    @required this.fullname,
    @required this.accessToken,
    @required this.imagenUrl,
    @required this.oauthFullname,
    @required this.oauthEmail,
  });

  factory UserSignInModel.fromJson(Map<String, dynamic> json) {
    return UserSignInModel(
      token: json['token'] as String,
      idPersona: json['id_persona'] as int,
      fullname: json['fullname'] as String,
      accessToken: json['access_token'] as String,
      imagenUrl: json['imagen_url'] as String,
      oauthFullname: json['oauth_fullname'] as String,
      oauthEmail: json['oauth_email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'id_persona': idPersona,
        'fullname': fullname,
        'access_token': accessToken,
        'imagen_url': imagenUrl,
        'oauth_fullname': oauthFullname,
        'oauth_email': oauthEmail,
      };

  @override
  String toString() {
    return """
    {
      "token": "${this.token}", 
      "id_persona" : ${this.idPersona}, 
      "fullname" : "${this.fullname}", 
      "access_token" : "${this.accessToken}",
      "imagen_url" : "${this.imagenUrl}",
      "oauth_fullname" : "${this.oauthFullname}", 
      "oauth_email" : "${this.oauthEmail}"
    }
    """;
  }
}
