import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/resources/auth_methods.dart';
import 'package:live_streaming_pro_2/screen/home_screen.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';
import 'package:live_streaming_pro_2/widgets/custom_button.dart';
import 'package:live_streaming_pro_2/widgets/custom_textfield.dart';
import 'package:live_streaming_pro_2/widgets/loading_indicator.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final AuthMethod _authMethod = AuthMethod();

  void signupUser() async {
    setState(() {
      _isLoading=true;
    });
    bool res = await _authMethod.signUpUser(
      context,
      _emailController.text,
      _userNameController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading=false;
    });
    if(res){
     Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body:_isLoading?const LoadingIndicator(): SingleChildScrollView(
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
                "Username",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextField(
                  controller: _userNameController,
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
                text: "Sign Up",
                onTap: signupUser,
              )
            ],
          ),
        ),
      ),
    );
  }
}
