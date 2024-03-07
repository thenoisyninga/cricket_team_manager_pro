// ignore_for_file: use_build_context_synchronously

import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

                  // Register
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // Email Field
                  TextField(
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                    controller: emailController,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Password
                  TextField(
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                    controller: passwordController,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Re enter password Field
                  TextField(
                    decoration: const InputDecoration(
                      label: Text("Re enter password"),
                    ),
                    controller: reEnterPasswordController,
                  ),

                  const SizedBox(
                    height: 20,
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
                          passwordController.text.isNotEmpty &&
                          passwordController.text ==
                              reEnterPasswordController.text) {
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
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("Signup"),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
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
