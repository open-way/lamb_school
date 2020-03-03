import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/models/hijo_model.dart';
import 'package:lamb_school/models/response_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';

class MisHijosService extends VitHttpService {
  Future<List<HijoModel>> getAll$() async {
    http.Response res = await httpGetAll('/setup/mis-hijos');
    print('Get all mis hijos');
    print('Get all mis hijos');
    print('Get all mis hijos');
    print('Get all mis hijos');
    print(res.body.toString());
    print('Get all mis hijos');
    print('Get all mis hijos');
    print('Get all mis hijos');
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = body['data'].cast<Map<String, dynamic>>();
      return data.map<HijoModel>((json) => HijoModel.fromJson(json)).toList();
    } else {
      throw new ResponseModel.fromJson(body['error']);
      // throw "Can't get mis hijos.";
    }
  }

  Future<HijoModel> getHijoById(String id) async {
    http.Response res = await httpGetById('/setup/mis-hijos', id, {});
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      //final data = body['data'];
      //return data.map<HijoModel>((json) => HijoModel.fromJson(json)).toList();
      final data = new HijoModel.fromJson(body['data']);
      return data;
    } else {
      throw new ResponseModel.fromJson(body['error']);
    }
  }
}
