import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/screen/login_screen.dart';
import 'package:live_streaming_pro_2/screen/signup_screen.dart';
import 'package:live_streaming_pro_2/widgets/custom_button.dart';
class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to\n Twitch",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Custombutton(
                text: "Log in",
                onTap: ()=>Navigator.pushNamed(context, LoginScreen.routeName),
              ),
            ),
            Custombutton(
              text: "Sign up",
              onTap: ()=>Navigator.pushNamed(context, SignUpScreen.routeName) ,
            ),
          ],
        ),
      ),
    );
  }
}
