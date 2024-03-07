import 'package:cricket_team_manager_pro/data_ops/upload_player.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ModifyDataDialogue extends StatefulWidget {
  const ModifyDataDialogue({super.key});

  @override
  State<ModifyDataDialogue> createState() => _ModifyDataDialogueState();
}

class _ModifyDataDialogueState extends State<ModifyDataDialogue> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController battingSkillsController = TextEditingController();
  TextEditingController bowlingSkillsController = TextEditingController();
  TextEditingController fieldingSkillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Profile Details"),
      content: SizedBox(
        height: 600,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  await picker.pickImage(source: ImageSource.gallery);
                },
                child: Text("Add/Replace Photo"),
              ),
              TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(label: Text("First Name"))),
              TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(label: Text("Last Name"))),
              TextField(
                  controller: bioController,
                  decoration: const InputDecoration(label: Text("Bio"))),
              TextField(
                  controller: ageController,
                  decoration: const InputDecoration(label: Text("Age"))),
              TextField(
                  controller: genderController,
                  decoration: const InputDecoration(label: Text("Gender"))),
              TextField(
                  controller: weightController,
                  decoration: const InputDecoration(label: Text("Weight"))),
              TextField(
                  controller: heightController,
                  decoration: const InputDecoration(label: Text("Height"))),
              TextField(
                  controller: battingSkillsController,
                  decoration:
                      const InputDecoration(label: Text("Batting Skills"))),
              TextField(
                  controller: bowlingSkillsController,
                  decoration:
                      const InputDecoration(label: Text("Bowling Skills"))),
              TextField(
                  controller: fieldingSkillsController,
                  decoration:
                      const InputDecoration(label: Text("Fielding Skills"))),
              ElevatedButton(
                  onPressed: () async {
                    await addPlayerToFirestore(Player(
                      firstNameController.text,
                      lastNameController.text,
                      usernameController.text,
                      "",
                      bioController.text,
                      int.tryParse(ageController.text) ?? 0,
                      genderController.text,
                      double.tryParse(weightController.text) ?? 0.0,
                      double.tryParse(heightController.text) ?? 0.0,
                      battingSkillsController.text.split(","),
                      bowlingSkillsController.text.split(","),
                      fieldingSkillsController.text.split(","),
                    ));

                    Navigator.pop(context);
                  },
                  child: Text("Done.")),
            ],
          ),
        ),
      ),
    );
  }
}
