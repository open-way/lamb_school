import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/models/anho_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';

class AnhosService extends VitHttpService {
  Future<List<AnhoModel>> getAll$(Map<String, String> queryParams) async {
    http.Response res = await httpGetByQuery('/setup/anhos', queryParams);

    print(res.body.toString());
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final data = body['data'].cast<Map<String, dynamic>>();
      return data.map<AnhoModel>((json) => AnhoModel.fromJson(json)).toList();
    } else {
      throw "Can't get anhos.";
    }
  }

  Future<List<AnhoModel>> getByQuery$(dynamic query) async {
    http.Response res = await httpGetByQuery('/setup/anhos', query);

    print(res.body.toString());
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final data = body['data'].cast<Map<String, dynamic>>();
      return data.map<AnhoModel>((json) => AnhoModel.fromJson(json)).toList();
    } else {
      throw "Can't get anhos.";
    }
  }
}
