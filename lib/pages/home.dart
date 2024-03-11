import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/pages/auth/login.dart';
import 'package:cricket_team_manager_pro/pages/player/player_display.dart';
import 'package:cricket_team_manager_pro/pages/team/team_display.dart';
import 'package:cricket_team_manager_pro/pages/team/teams_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentPlayerFromFirestore(),
        builder: (context, snapshot) {
          if (Player.fromDefault() == snapshot.data) {
            // Enter Data
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProfileView(playerId: playerId),
            //   ),
            // );
          }

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text("H O M E"),
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () async {
                    User? user = await getCurrentUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileView(
                          playerId: user!.uid,
                        ),
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Image(
                  //   image: AssetImage('assets/images/cover2.jpg'),
                  //   fit: BoxFit.cover,
                  //   height: MediaQuery.of(context).size.height * 0.35,
                  //   width: MediaQuery.of(context).size.width,
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TeamSelectPage(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 19, 66, 22),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Manage & Create\nTeams",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
