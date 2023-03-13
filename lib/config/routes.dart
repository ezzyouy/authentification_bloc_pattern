import 'package:auth_app/blocs/app/app_bloc.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/screens/signIn_screen.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPage(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [SignInScreen.page()];
  }
}
