import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/provider/user_provider.dart';
import 'package:live_streaming_pro_2/screen/home_screen.dart';
import 'package:live_streaming_pro_2/screen/login_screen.dart';
import 'package:live_streaming_pro_2/screen/onboarding_screen.dart';
import 'package:live_streaming_pro_2/screen/signup_screen.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_)=>UserProvider()
        )
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
/// Hello
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
        SignUpScreen.routeName:(context)=> const SignUpScreen(),
        HomeScreen.routeName:(context)=>const HomeScreen()
      },
      home: const OnboardingScreen(),
    );
  }
}
