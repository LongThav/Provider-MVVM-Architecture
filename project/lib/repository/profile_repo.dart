import 'package:flutter/material.dart';
import 'package:project/data/network/base_api_service.dart';
import 'package:project/data/network/network_api_service.dart';
import 'package:project/db_helper/chache_token.dart';
import 'package:project/model/profile_model.dart';
import 'package:project/model/random_user_model.dart';
import 'package:project/rest/url_base.dart';
import 'package:project/utils/get_header.dart';

class ProfileRepo {
  BaseApiService baseApiService = NetworkApiService();
  final CacheHelper _cacheHelper = CacheHelper();
  Future<ProfileModel> getProfileRepo() async {
    dynamic response;
    try {
      String token = await _cacheHelper.getToken();
      debugPrint("Token: $token");
      response = await baseApiService.getGetApiResponse(mainUrl + getProfile,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return ProfileModel.fromJson(response);
    } catch (err) {
      debugPrint("Error in repo: $err");
      throw Exception(err);
    }
  }

  Future<RandomInfoModel> fetchRandomUser() async {
    try {
      dynamic response = await baseApiService.getGetApiResponse(
        randomUserUrl,
      );
      debugPrint("Response: $response");
      return RandomInfoModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future logoutRepo() async {
    try {
      String token = await _cacheHelper.getToken();
      debugPrint("Token: $token");
      dynamic response = await baseApiService.getPostApiResponse(
          mainUrl + logout,
          requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
