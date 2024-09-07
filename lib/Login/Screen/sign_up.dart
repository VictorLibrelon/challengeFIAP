import 'package:fiap_challenge_project/Login/Screen/home_screen.dart';
import 'package:fiap_challenge_project/Login/Screen/login.dart';
import 'package:fiap_challenge_project/Login/Services/authentication.dart';
import 'package:fiap_challenge_project/Login/Widget/snack_bar.dart';
import 'package:flutter/material.dart';
import '../Widget/button.dart';
import '../Widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser() async {
    String res = await AuthServicess().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    if (res == "Sucesso") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height / 2.7,
                  child: Image.asset("images/SignUp.png"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFieldInput(
                        textEditingController: nameController,
                        hintText: "Digite seu Nome",
                        icon: Icons.person,
                      ),
                      TextFieldInput(
                        textEditingController: emailController,
                        hintText: "Digite seu E-mail",
                        icon: Icons.email,
                      ),
                      TextFieldInput(
                        textEditingController: passwordController,
                        hintText: "Digite sua senha",
                        isPass: true,
                        icon: Icons.lock,
                      ),
                    ],
                  ),
                ),
                MyButton(onTab: signUpUser, text: "Cadastrar"),
                SizedBox(height: height / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Já tem uma conta? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
