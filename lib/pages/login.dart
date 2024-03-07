// ignore_for_file: use_build_context_synchronously

import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/pages/home.dart';
import 'package:cricket_team_manager_pro/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 200,
                    color: Colors.red,
                    child: const Text("LOGO"),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // Login
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // Email Field
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      errorText: emailError,
                    ),
                    controller: emailController,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Password
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      errorText: passwordError,
                    ),
                    controller: passwordController,
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // Login Button
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        String? result = await loginWithEmailAndPassword(
                            emailController.text, passwordController.text);

                        if (result != "success") {
                          // If email error
                          if (result == "invalid-email") {
                            setState(() {
                              emailError = "Invalid Email";
                            });
                          } else if (result == "unverified-email") {
                            setState(() {
                              emailError == "Unverified Mail";
                            });
                          } else if (result == "invalid-credential") {
                            print("triggered");
                            setState(() {
                              emailError == "Email or password wrong";
                            });
                          } else {
                            setState(
                              () {
                                emailError = null;
                              },
                            );
                          }

                          Navigator.of(context).pop();
                        } else {
                          setState(() {
                            emailError == null;
                            passwordError = null;
                          });

                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not registed?,"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
