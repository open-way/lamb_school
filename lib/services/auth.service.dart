import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lamb_school/models/response_model.dart';
import 'package:lamb_school/models/user_signin_model.dart';
import 'package:lamb_school/enviroment.dev.dart';
import 'package:lamb_school/models/user_signup_model.dart';

abstract class BaseAuth {
  Future<UserSignInModel> signIn(String email, String password);

  Future<UserSignUpModel> signUp(String idTipodocumento, String username,
      String password, String passwordConfirm);

  // Future<FirebaseUser> getCurrentUser();
  Future<dynamic> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class AuthService implements BaseAuth {
  final String theUrl = '$baseAllUrl/auth';

  Future<UserSignInModel> signIn(String username, String password) async {
    http.Response res = await http.post(
      '$theUrl/sign-in',
      body: {'username': username, 'password': password, 'no_caduca': 'true'},
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = new UserSignInModel.fromJson(body['data']);
      return data;
    } else {
      throw new ResponseModel.fromJson(body['error']);
      // throw 'No es posible iniciar sesión.';
    }
  }

  Future<UserSignUpModel> signUp(String idTipodocumento, String username,
      String password, String passwordConfirm) async {
    var data = {
      'id_tipodocumento': idTipodocumento,
      'username': username,
      'password': password,
      'password_confirmation': passwordConfirm,
    };
    print(data.toString());
    http.Response res = await http.post('$theUrl/sign-up', body: data);
    print('-------');
    print('-------');
    print('-------');
    print('-------');
    print('-------');
    print(res.toString());
    print(res.body.toString());

    final body = jsonDecode(res.body);
    print('-------');
    print('-------');
    print('-------');
    print('-------');

    if (res.statusCode == 200) {
      final data = new UserSignUpModel.fromJson(body['data']);
      return data;
    } else {
      throw new ResponseModel.fromJson(body['error']);
    }
    // AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
    //     email: email, password: password);
    // FirebaseUser user = result.user;
    // return user.uid;
  }

  Future<dynamic> getCurrentUser() async {}

  Future<void> signOut() async {}
  Future<void> sendEmailVerification() async {}
  Future<bool> isEmailVerified() async {}
}
/*
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
*/
