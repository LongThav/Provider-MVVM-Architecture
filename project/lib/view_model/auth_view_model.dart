import 'package:flutter/material.dart';
import 'package:project/db_helper/chache_token.dart';
import 'package:project/model/login_model.dart';
import 'package:project/utils/snack_bar.dart';

import '../repository/auth_repo.dart';
import '../utils/handle_push_view.dart';
import '../view/index_view.dart';

ValueNotifier<SignInModel> signInModel =
    ValueNotifier(SignInModel(login: Login(userLogin: UserLogin())));

class AuthNotifier extends ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  void setLoadingLogin(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setLoadingSignUp(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  final CacheHelper _cacheHelper = CacheHelper();
  Future loginAuthNotifier(dynamic data, BuildContext context) async {
    debugPrint("Login");
    setLoadingLogin(true);
    _authRepo.loginRep(data).then((value)async{
      setLoadingLogin(false);
      _cacheHelper.writeToken(value.login.token);
      snackBar(context, "Login successfully");
      pushReplace(context, const IndexView());
    }).onError((error, stackTrace) {
      debugPrint("Error: $error");
      snackBar(context, "Email or Password incorrect");
      setLoadingLogin(false);
    });
    notifyListeners();
  }

  Future signUpNotifier(dynamic data, BuildContext context) async {
    setLoadingSignUp(true);
    _authRepo.createAccountRepo(data).then((value) {
      setLoadingSignUp(false);
      debugPrint("Data: $value");
      snackBar(context, "Create account successfully");
    }).onError((error, stackTrace) {
      debugPrint("Error: $error");
      setLoadingSignUp(false);
    });
    notifyListeners();
  }
}
