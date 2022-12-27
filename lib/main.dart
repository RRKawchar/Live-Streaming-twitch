import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/screen/login_screen.dart';
import 'package:live_streaming_pro_2/screen/onboarding_screen.dart';
import 'package:live_streaming_pro_2/screen/signup_screen.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live streaming app',
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme.of(context).copyWith(
              backgroundColor: backgroundColor,
              elevation: 0,
              titleTextStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),

                  iconTheme:const IconThemeData(
                    color: primaryColor
                  )
      ),
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName:(context)=>const LoginScreen(),
        SignUpScreen.routeName:(context)=> const SignUpScreen()
      },
      home: const OnboardingScreen(),
    );
  }
}
