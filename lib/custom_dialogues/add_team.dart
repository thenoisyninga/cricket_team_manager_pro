import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/linked_ops/linked_ops_team.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTeamDialogue extends StatefulWidget {
  const AddTeamDialogue({super.key});

  @override
  State<AddTeamDialogue> createState() => _AddTeamDialogueState();
}

class _AddTeamDialogueState extends State<AddTeamDialogue> {
  TextEditingController teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Team"),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: teamNameController,
              decoration: InputDecoration(
                label: Text("Team Name"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (teamNameController.text.isNotEmpty) {
                  User? user = await getCurrentUser();

                  if (user != null) {
                    createTeam(
                      Team(
                        teamNameController.text,
                        user.uid,
                      ),
                    );
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text("Create Team"),
            ),
          ],
        ),
      ),
    );
  }
}
