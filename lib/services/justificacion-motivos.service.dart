import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/models/justificacion_motivo_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';

class JustificacionMotivosService extends VitHttpService {
  Future<List<JustificacionMotivoModel>> getAll$() async {
    http.Response res = await httpGetAll('/setup/justificacion-motivos');
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = body['data'].cast<Map<String, dynamic>>();
      return data
          .map<JustificacionMotivoModel>(
              (json) => JustificacionMotivoModel.fromJson(json))
          .toList();
    } else {
      throw "Can't get justificacion motivos.";
    }
  }
}
