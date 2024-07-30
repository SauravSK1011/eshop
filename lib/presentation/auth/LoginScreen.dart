import 'package:eshop/core/services/AuthServices.dart';
import 'package:eshop/presentation/auth/SignupScreen.dart';
import 'package:eshop/presentation/auth/Widget/MyToast.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/presentation/home/HomeScreen.dart';
import 'package:eshop/presentation/auth/Widget/MyButton.dart';
import 'package:eshop/presentation/auth/Widget/MyTextfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void loginUser() async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    if (emailValid && passwordController.text.isNotEmpty) {
      bool status = await AuthServices().loginUser(
          context: context,
          email: emailController.text,
          password: passwordController.text);
      if (status) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      shotToast("Email or Password is not formated", Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "e-Shop",
          style: TextStyle(color: mainblue, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 1,
          ),
          Column(
            children: [
              TextFieldInput(
                  icon: Icons.email,
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.text),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Enter your passord',
                textInputType: TextInputType.text,
                isPass: true,
              ),
            ],
          ),
          Column(
            children: [
              MyButton(onTap: loginUser, text: "Login"),
              Row(
                children: [
                  Expanded(
                    child: Container(height: 1, color: Colors.black26),
                  ),
                  Text(
                    "  or  ",
                  ),
                  Expanded(
                    child: Container(height: 1, color: Colors.black26),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1,
          )
        ],
      ),
    );
  }
}
