import 'dart:convert';

import 'package:lamb_school/models/dashboard_model.dart';
import 'package:lamb_school/services/inteceptors/vit_http.service.dart';
import 'package:http/http.dart' as http;

class DashboardService extends VitHttpService {
  Future<DashboardModel> getDashboard$() async {
    http.Response res = await httpGetAll('/portal-padre/my-dashboard');
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      final data = new DashboardModel.fromJson(body['data']);
      return data;
    } else {
      throw "Can't get dashboard.";
    }
  }
}
