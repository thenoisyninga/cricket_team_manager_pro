import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/upload_player.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/pages/login.dart';
import 'package:cricket_team_manager_pro/pages/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H O M E"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(),
                ),
              );

              // addPlayerToFirestore(Player.fromDefault());
            },
            icon: const Icon(Icons.person),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  print(await logout());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text("Logout"),
              )
            ];
          })
        ],
      ),
      body: const Center(child: const Text("Home,")),
    );
  }
}
