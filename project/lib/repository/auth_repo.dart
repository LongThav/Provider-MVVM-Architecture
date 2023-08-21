import 'package:project/data/network/base_api_service.dart';
import 'package:project/data/network/network_api_service.dart';
import 'package:project/model/login_model.dart';
import 'package:project/rest/url_base.dart';

class AuthRepo {
  BaseApiService baseApiService = NetworkApiService();
  Future<SignInModel> loginRep(dynamic data) async {
    dynamic response;
    try {
      String url = mainUrl + signIn;
      response = await baseApiService.getPostApiResponse(url, data: data);
      return SignInModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<dynamic> createAccountRepo(dynamic data) async {
    try {
      String url = mainUrl + signUp;
      dynamic response = await baseApiService.getPostApiResponse(url, data: data);
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }
}
