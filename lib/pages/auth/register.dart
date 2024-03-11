// ignore_for_file: use_build_context_synchronously

import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/pages/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController reEnterPasswordController =
      TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  Container(
                    alignment: Alignment.center,
                    child: const Image(
                      height: 150,
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                    ),
                  ),

                  // Register
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
                  ),

                  // Email Field
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Email"),
                          ),
                          controller: emailController,
                        ),

                        // Password
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Password"),
                          ),
                          controller: passwordController,
                        ),

                        // Re enter password Field
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Re enter password"),
                          ),
                          controller: reEnterPasswordController,
                        ),
                      ],
                    ),
                  ),

                  // Login Button
                  GestureDetector(
                    onTap: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          passwordController.text ==
                              reEnterPasswordController.text) {
                        showDialog(
                          context: context,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        String? result = await signUpWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );

                        if (result != "success") {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Signup",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a player?,"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Text(
                          "Login.",
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
