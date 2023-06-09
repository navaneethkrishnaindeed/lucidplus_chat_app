import 'package:lucidplus_chat_app/presentation/add_telegram_user/add_telegram_user.dart';
import 'package:lucidplus_chat_app/presentation/auth/login_screen/login_screen.dart';
import 'package:lucidplus_chat_app/presentation/auth/signup_screen/signup_screen.dart';
import 'package:lucidplus_chat_app/presentation/home/home.dart';
import 'package:lucidplus_chat_app/presentation/splash_screen/splash_screen.dart';
import 'package:lucidplus_chat_app/presentation/view_saved_users/view_saved_users.dart';
import 'package:lucidplus_chat_app/presentation/women_safty_web_view/women_safty_web_view.dart';

mixin RoutPaths {
  static const String splashScreen = "/SPLASH_SCREEN";
  static const String loginScreen = "/LOGIN_SCREEN";
  static const String signUpScreen = "/SIGNUP_SCREEN";
  static const String homeScreen = "/HOME_SCREEN";
  static const String mainScreen = "/MAIN_SCREEN";
  static const String webView = "/WEB_VIEW";
  static const String addUser = "/ADD_USER";
  static const String savedUsers = "/SAVED_USERS";
}

abstract class GetNamedRouts {
  static getRouts() {
    return {
      RoutPaths.splashScreen: (context) => const SplashScreen(),
      RoutPaths.loginScreen: (context) => LoginScreen(),
      RoutPaths.signUpScreen: (context) => SignupScreen(),
      RoutPaths.homeScreen: (context) => HomeScreen(),
      RoutPaths.webView: (context) => WomenSaftyWebView(),
      RoutPaths.addUser: (context) => AddUserScreen(),
      RoutPaths.savedUsers: (context) => SavedUsers()
    };
  }
}
