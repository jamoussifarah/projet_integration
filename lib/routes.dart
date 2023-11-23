//import 'screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:projet_d_integration/Screens/compilte_profile/complete_profile_screen.dart';
import 'package:projet_d_integration/Screens/opt/opt_screen.dart';
import 'package:projet_d_integration/Screens/sign_up/sign_up_screen.dart';
import 'package:projet_d_integration/Screens/splash/splash_screen.dart';
import 'package:projet_d_integration/widgets/bottomnavigationbar.dart';

import 'screens/forgot_password/forgot_password_screen.dart';

import 'screens/login_success/login_success_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';




final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  Bottom.routeName: (context) => const Bottom(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
};