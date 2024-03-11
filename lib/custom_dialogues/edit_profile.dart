import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileDialogue extends StatefulWidget {
  const EditProfileDialogue({super.key, required this.currentPlayer});

  final Player currentPlayer;

  @override
  State<EditProfileDialogue> createState() => _EditProfileDialogueState();
}

class _EditProfileDialogueState extends State<EditProfileDialogue> {
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
  void initState() {
    firstNameController.text = widget.currentPlayer.firstName;
    lastNameController.text = widget.currentPlayer.lastName;
    usernameController.text = widget.currentPlayer.username;
    bioController.text = widget.currentPlayer.bio;
    ageController.text = (widget.currentPlayer.age).toString();
    genderController.text = widget.currentPlayer.gender;
    weightController.text = widget.currentPlayer.weight.toString();
    heightController.text = widget.currentPlayer.height.toString();
    battingSkillsController.text = widget.currentPlayer.battingSkills.join(",");
    bowlingSkillsController.text = widget.currentPlayer.bowlingSkills.join(",");
    fieldingSkillsController.text =
        widget.currentPlayer.fieldingSkills.join(",");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Profile"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      // final ImagePicker picker = ImagePicker();
                      // await picker.pickImage(source: ImageSource.gallery);
                    },
                    child: const Text("Add/Replace Photo"),
                  ),
                  TextField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(label: Text("First Name"))),
                  TextField(
                      controller: lastNameController,
                      decoration:
                          const InputDecoration(label: Text("Last Name"))),
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
                      decoration: const InputDecoration(
                          label: Text("Batting Skills (Comma Seperated)"))),
                  TextField(
                      controller: bowlingSkillsController,
                      decoration: const InputDecoration(
                          label: Text("Bowling Skills (Comma Seperated)"))),
                  TextField(
                      controller: fieldingSkillsController,
                      decoration: const InputDecoration(
                          label: Text("Fielding Skills (Comma Seperated)"))),
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
                          "",
                        ));

                        Navigator.pop(context);
                      },
                      child: Text("Done.")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
