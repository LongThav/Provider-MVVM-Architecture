import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheProfile{
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  String keyProfile = "";
  String noKeyProfile = "noKey";

  void writeUserInfor(String value){
    _flutterSecureStorage.write(key: keyProfile, value: value);
  }

  Future<String> getUserInfor()async{
    String? userInfor = await _flutterSecureStorage.read(key: keyProfile);
    return userInfor ?? noKeyProfile;
  }

  void deleteAll(){
    _flutterSecureStorage.deleteAll();
  }
}