import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/dialogues/edit_profile.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentPlayerFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Player player = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text("P R O F I L E"),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
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
                  ),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 100,
                        child: Icon(
                          Icons.person,
                          size: 100,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                player.firstName == ""
                                    ? "Enter data using the button above."
                                    : player.firstName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: player.firstName == "" ? 20 : 30),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                player.lastName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ],
                          ),
                          Text(
                            player.username,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            player.bio,
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        ],
                      ),
                      const SizedBox(),
                    ],
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
