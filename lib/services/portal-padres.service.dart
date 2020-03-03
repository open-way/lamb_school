import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/models/agenda_model.dart';
import 'package:lamb_school/models/operation_model.dart';
import 'package:lamb_school/models/asistencia_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';

class PortalPadresService extends VitHttpService {
  Future<EstadoCuentaModel> getEstadoCuenta$(
      Map<String, String> queryParams) async {
    http.Response res =
        await httpGetByQuery('/portal-padre/mi-estado-cuenta', queryParams);
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = EstadoCuentaModel.fromJson(body['data']);
      return data;
    } else {
      throw "Can't get estado de cuenta.";
    }
  }

  Future<List<AsistenciaModel>> getAsistencias(
      Map<String, String> queryParams) async {
    http.Response res =
        await httpGetByQuery('/portal-padre/asistencias', queryParams);

    final body = jsonDecode(res.body);
    print(res.body.toString());

    if (res.statusCode == 200) {
      final data = body['data'].cast<Map<String, dynamic>>();
      return data
          .map<AsistenciaModel>((json) => AsistenciaModel.fromJson(json))
          .toList();
    } else {
      throw "Can't get asistencias.";
    }
  }

  Future<List<AgendaModel>> getAgenda(Map<String, String> queryParams) async {
    http.Response res =
        await httpGetByQuery('/portal-padre/agendas', queryParams);
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = body['data'].cast<Map<String, dynamic>>();
      return data
          .map<AgendaModel>((json) => AgendaModel.fromJson(json))
          .toList();
    } else {
      print("Can't get agenda.");
    }
  }
}
