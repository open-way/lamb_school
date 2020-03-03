import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class TokenInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      final storage = new FlutterSecureStorage();
      final token = await storage.read(key: 'token') ?? '';
      data.headers['Authorization'] = token;
      // data.headers['Content-Type'] = 'application/json';
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}
