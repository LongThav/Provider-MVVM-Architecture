import 'package:flutter/material.dart';
import 'package:project/db_helper/chache_token.dart';
import 'package:project/utils/handle_push_view.dart';
import 'package:project/view/index_view.dart';

import 'login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    CacheHelper cacheHelper = CacheHelper();
    String token = await cacheHelper.getToken();
    debugPrint("Token: $token");
    if (token == cacheHelper.noToken) {
      Future.delayed(const Duration(milliseconds: 600), () {
        pushReplace(context, const LoginView());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 600), () {
        pushReplace(context, const IndexView());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash View"),
      ),
    );
  }
}
