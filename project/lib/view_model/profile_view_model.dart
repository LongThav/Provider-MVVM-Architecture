import 'package:flutter/material.dart';
import 'package:project/data/response/api_response.dart';
import 'package:project/model/profile_model.dart';
import 'package:project/model/random_user_model.dart';
import 'package:project/repository/profile_repo.dart';
import 'package:project/utils/handle_push_view.dart';
import 'package:project/utils/snack_bar.dart';
import 'package:project/view/login_view.dart';

class ProfileNotifier extends ChangeNotifier {
  ApiResponse<ProfileModel> _apiResponse = ApiResponse.loading();
  ApiResponse<ProfileModel> get apiResponse => _apiResponse;

  ApiResponse<RandomInfoModel> _randomUser = ApiResponse.loading();
  ApiResponse<RandomInfoModel> get randomUser => _randomUser;

  final ProfileRepo _profileRepo = ProfileRepo();

  void _setApiResponse(ApiResponse<ProfileModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  void _setRandomResponse(ApiResponse<RandomInfoModel> response) {
    _randomUser = response;
    notifyListeners();
  }

  Future<void> fetchingProfileNotifier() async {
    _setApiResponse(ApiResponse.loading());
    try {
      final value = await _profileRepo.getProfileRepo();
      debugPrint("Value: ${value.success}");
      _setApiResponse(ApiResponse.completed(value));
    } catch (err) {
      debugPrint("Error: $err");
      debugPrint("Fetching");
      _setApiResponse(ApiResponse.error(err.toString()));
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchingRandomUser() async {
    _setRandomResponse(ApiResponse.loading());
    try {
      final value = await _profileRepo.fetchRandomUser();
      debugPrint("Value: ${value.results.length}");
      _setRandomResponse(ApiResponse.completed(value));
      debugPrint("Success");
    } catch (err) {
      debugPrint("Error in catch");
      debugPrint("Error: $err");
      _setRandomResponse(ApiResponse.error(err.toString()));
    } finally {
      notifyListeners();
    }
  }

  bool _logout = false;
  bool get lgout => _logout;

  void setLoadingLogut(bool value) {
    _logout = value;
    notifyListeners();
  }

  Future logoutViewModel(BuildContext context) async {
    setLoadingLogut(true);
    _profileRepo.logoutRepo().then((value) {
      setLoadingLogut(false);
      pushReplace(context, const LoginView());
      snackBar(context, "User Logout Successfully");
    }).onError((error, stackTrace) {
      debugPrint("Error Logout");
      setLoadingLogut(false);
    });
  }
}
