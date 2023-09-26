import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'network_services.dart';

class FoodieService {
  NetworkService networkService = NetworkService();

  Future<http.Response> userRegister(data) async {
    debugPrint(data.runtimeType.toString());
    return await networkService.post(Uri.parse('https://snapkaro.com/eazyrooms_staging/api/user_registeration'), data);
  }

  Future<http.Response> userLogin(data) async {
    return await networkService.post(Uri.parse('https://snapkaro.com/eazyrooms_staging/api/userlogin'), data);
  }
}
