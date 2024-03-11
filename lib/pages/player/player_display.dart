import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/custom_dialogues/edit_profile.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key, required this.playerId});

  final String playerId;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPlayerFromFirestore(widget.playerId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Player player = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text("P R O F I L E"),
                backgroundColor: Colors.transparent,
                actions: [
                  FutureBuilder(
                      future: getCurrentUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          User user = snapshot.data!;
                          if (user.uid == widget.playerId) {
                            return IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => EditProfileDialogue(
                                    currentPlayer: player,
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              icon: const Icon(Icons.edit),
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const CircleAvatar(
                          radius: 100,
                          child: Icon(
                            Icons.person,
                            size: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  player.firstName == ""
                                      ? "Enter data using the button above."
                                      : player.firstName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          player.firstName == "" ? 20 : 30),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  player.lastName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Text(
                                player.bio,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Gender",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      player.gender,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    Text(
                                      "Age",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      player.age.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Weight",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${player.weight}kgs",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    Text(
                                      "Height",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${player.height}\'\'",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Divider(
                              color: Colors.grey[800],
                            ),
                            const SizedBox(height: 40),
                            Column(
                              children: [
                                const Text(
                                  "Batting Skills",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  children: player.battingSkills
                                      .map((e) => Text(
                                            "${e}",
                                            style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 15),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Divider(
                              color: Colors.grey[800],
                            ),
                            const SizedBox(height: 40),
                            Column(
                              children: [
                                const Text(
                                  "Bowling Skills",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  children: player.bowlingSkills
                                      .map((e) => Text(
                                            "${e}",
                                            style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 15),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Divider(
                              color: Colors.grey[800],
                            ),
                            const SizedBox(height: 40),
                            Column(
                              children: [
                                const Text(
                                  "Fielding Skills",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  children: player.fieldingSkills
                                      .map((e) => Text(
                                            "${e}",
                                            style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 15),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
