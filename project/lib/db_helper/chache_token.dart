import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/utils/handle_push_view.dart';
import 'package:project/view/login_view.dart';

class CacheHelper {
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  String token = "";
  String noToken = "noToken";

  void writeToken(String value) {
    _flutterSecureStorage.write(key: token, value: value);
  }

  Future<String> getToken() async {
    String? tokenUser = await _flutterSecureStorage.read(key: token);
    return tokenUser ?? noToken;
  }

  void deleteAll(BuildContext context) {
    _flutterSecureStorage.deleteAll().then((value){
      pushReplace(context, const LoginView());
    });
  }
}
