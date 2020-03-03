import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';

class JustificacionesService extends VitHttpService {
  Future postAll$(Map<String, String> postParams) async {
    http.Response res =
        await httpPost('/portal-padre/justificaciones', postParams);
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = body['data'];
      return data;
    } else {
      throw "Can't save justificaciones.";
    }
  }
}
