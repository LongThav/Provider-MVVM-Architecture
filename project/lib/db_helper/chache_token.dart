import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  void deleteAll() {
    _flutterSecureStorage.deleteAll();
  }
}
