// ignore_for_file: use_build_context_synchronously

import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/pages/home.dart';
import 'package:cricket_team_manager_pro/pages/auth/register.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: const Image(
                      height: 150,
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                    ),
                  ),

                  // Login
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
                  ),

                  // Email Field
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      errorText: emailError,
                    ),
                    controller: emailController,
                  ),

                  // Password
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      errorText: passwordError,
                    ),
                    controller: passwordController,
                  ),

                  // Login Button
                  Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                                  emailController.text,
                                  passwordController.text);

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
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
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
