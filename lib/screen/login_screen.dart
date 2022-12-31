import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/resources/auth_methods.dart';
import 'package:live_streaming_pro_2/screen/home_screen.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';
import 'package:live_streaming_pro_2/widgets/custom_button.dart';
import 'package:live_streaming_pro_2/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethod _authMethod = AuthMethod();

  userLogin() async {
    bool res = await _authMethod.loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );
    if(res){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextField(
                  controller: _emailController,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextField(
                  controller: _passwordController,
                ),
              ),
              const SizedBox(height: 20),
              Custombutton(
                text: "Log In",
                onTap: userLogin,
              )
            ],
          ),
        ),
      ),
    );
  }
}
