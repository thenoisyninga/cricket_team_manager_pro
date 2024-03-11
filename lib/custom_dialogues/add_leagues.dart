// ignore_for_file: use_build_context_synchronously

import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/linked_ops/linked_ops_league.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddLeagueDialogue extends StatefulWidget {
  const AddLeagueDialogue({super.key, required this.teamId});

  final String teamId;

  @override
  State<AddLeagueDialogue> createState() => _AddLeagueDialogueState();
}

class _AddLeagueDialogueState extends State<AddLeagueDialogue> {
  TextEditingController leagueNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New League"),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: leagueNameController,
              decoration: InputDecoration(
                label: Text("League Name"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (leagueNameController.text.isNotEmpty) {
                  User? user = await getCurrentUser();

                  if (user != null) {
                    createLeague(
                      League.fromDefault(
                        leagueNameController.text,
                      ),
                      widget.teamId,
                    );
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text("Create League"),
            ),
          ],
        ),
      ),
    );
  }
}
