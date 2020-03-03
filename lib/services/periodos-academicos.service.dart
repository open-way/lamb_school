import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/models/periodo_academico_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';

class PeriodosAcademicosService extends VitHttpService {
  Future<List<PeriodoAcademicoModel>> getAll$(
      Map<String, String> queryParams) async {
    http.Response res =
        await httpGetByQuery('/setup/periodos-academicos', queryParams);

    print(res.body.toString());
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final data = body['data'].cast<Map<String, dynamic>>();
      return data
          .map<PeriodoAcademicoModel>(
              (json) => PeriodoAcademicoModel.fromJson(json))
          .toList();
    } else {
      throw "Can't get periodos academicos.";
    }
  }
}
