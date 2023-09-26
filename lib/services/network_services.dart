// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NetworkService {
  static final NetworkService _instance = NetworkService.internal();
  factory NetworkService() => _instance;
  http.Response? response;
  var client = http.Client();

  NetworkService.internal();

  Future<http.Response> get(var url, {Map<String, String>? headers}) async {
    return client.get(url, headers: headers).then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> post(Uri url, body) {
    return client.post(url, body: body).then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> put(Uri url, {Map<String, String>? headers, body, encoding}) {
    return client.put(url, headers: headers, body: body, encoding: encoding).then((http.Response response) {
      return handleResponse(response);
    });
  }

  Future<http.Response> delete(Uri url, {Map<String, String>? headers}) {
    return client.delete(url, headers: headers).then((http.Response response) {
      return handleResponse(response);
    });
  }

  http.Response handleResponse(http.Response response) {
    return response;
  }
}
