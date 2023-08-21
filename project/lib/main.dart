import 'package:flutter/material.dart';
import 'package:project/view/splash_viev.dart';
import 'package:project/view_model/auth_view_model.dart';
import 'package:project/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthNotifier()),
      ChangeNotifierProvider(create: (context) => ProfileNotifier())
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    ),
  ),
);
