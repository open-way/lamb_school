import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/models/test_https_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';
// import 'dart:developer' as developer;

class TestHttpsService extends VitHttpService  {

  Future<List<TestHttpsModel>> testHttps$() async {
    http.Response res = await lambHttp.get(
        'https://api-lamb-school-financial.upeu.edu.pe/api/matricula/test_connect');
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final data = body['data'].cast<Map<String, dynamic>>();
      return data
          .map<TestHttpsModel>((json) => TestHttpsModel.fromJson(json))
          .toList();
    } else {
      throw "Can't get test http.";
    }
  }
}
