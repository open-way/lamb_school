import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:lamb_school/enviroment.dev.dart';
import 'package:lamb_school/services/inteceptors/token_interceptor.service.dart';
import 'package:flutter/foundation.dart';

// debugPrint('movieTitle: $movieTitle');
class VitHttpService {
  http.Client lambHttp = HttpClientWithInterceptor.build(interceptors: [
    TokenInterceptor(),
  ]);

  final String baseUrl = baseApiGeneral;
  final String intermediateUrl = intermediateApiGeneral;

  // Methods generals

  Future<dynamic> httpGetAll(String otherUrl) {
    // log
    debugPrint('httpGetAll: $intermediateUrl$otherUrl');
    var uri = new Uri.http(baseUrl, '$intermediateUrl$otherUrl');
    return lambHttp.get(uri);
  }

  Future<dynamic> httpGetByQuery(
      String otherUrl, Map<String, String> queryParams) {
    debugPrint(
        'httpGetByQuery: $intermediateUrl$otherUrl; queryParams: ${queryParams.toString()}');
    var uri = new Uri.http(baseUrl, '$intermediateUrl$otherUrl', queryParams);
    return lambHttp.get(uri);
  }

  Future<dynamic> httpGetById(
      String otherUrl, String id, Map<String, String> queryParams) {
    debugPrint(
        'httpGetById: $intermediateUrl$otherUrl/$id; queryParams: ${queryParams.toString()}');
    var uri =
        new Uri.http(baseUrl, '$intermediateUrl$otherUrl/$id', queryParams);
    return lambHttp.get(uri);
  }

  Future<dynamic> httpPost(String otherUrl, Map<String, dynamic> body) {
    debugPrint('httpPost: $intermediateUrl$otherUrl');
    var uri = new Uri.http(baseUrl, '$intermediateUrl$otherUrl');
    return lambHttp.post(uri, body: body);
  }

  Future<dynamic> httpPut(
      String otherUrl, String id, Map<String, dynamic> body) {
    debugPrint('httpPut: $intermediateUrl$otherUrl/$id');
    var uri = new Uri.http(baseUrl, '$intermediateUrl$otherUrl/$id');
    return lambHttp.put(uri, body: body);
  }

  Future<dynamic> httpPatch(
      String otherUrl, String id, Map<String, dynamic> body) {
    debugPrint('httpPatch: $intermediateUrl$otherUrl/$id');
    var uri = new Uri.http(baseUrl, '$intermediateUrl$otherUrl/$id');
    return lambHttp.patch(uri, body: body);
  }

  Future<dynamic> httpDelete(String otherUrl, String id) {
    debugPrint('httpDelete: $intermediateUrl$otherUrl/$id');
    var uri = new Uri.http(baseUrl, '$intermediateUrl$otherUrl/$id');
    return lambHttp.delete(uri);
  }
}
