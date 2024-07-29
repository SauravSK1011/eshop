import 'package:eshop/core/services/AuthServices.dart';
import 'package:eshop/presentation/Auth/LoginScreen.dart';
import 'package:eshop/presentation/Auth/Widget/MyTextfield.dart';
import 'package:eshop/presentation/Auth/Widget/MyToast.dart';
import 'package:eshop/presentation/home/HomeScreen.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';

import 'Widget/MyButton.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  void signUpUser() async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    if (emailValid && passwordController.text.isNotEmpty) {
      await AuthServices().signUpUser(context: context,
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text);
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
    } else {
      shotToast("Email or Password Empty", Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                  icon: Icons.person,
                  textEditingController: nameController,
                  hintText: 'Enter your name',
                  textInputType: TextInputType.text),
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
              MyButton(onTap: signUpUser, text: "Signup"),
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
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        " Login",
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
