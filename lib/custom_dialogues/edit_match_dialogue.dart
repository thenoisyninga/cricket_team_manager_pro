import 'package:cricket_team_manager_pro/data_ops/match_ops.dart';
import 'package:cricket_team_manager_pro/models/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditMatchDialogue extends StatefulWidget {
  const EditMatchDialogue(
      {super.key, required this.match, required this.matchId});

  final String matchId;
  final CricketMatch match;
  @override
  State<EditMatchDialogue> createState() => _EditMatchDialogueState();
}

class _EditMatchDialogueState extends State<EditMatchDialogue> {
  TextEditingController ballsFacedTeam1Controller = TextEditingController();
  TextEditingController ballsFacedTeam2Controller = TextEditingController();
  TextEditingController runsTeam1Controller = TextEditingController();
  TextEditingController runsTeam2Controller = TextEditingController();
  TextEditingController numPlayesOutTeam1Controller = TextEditingController();
  TextEditingController numPlayesOutTeam2Controller = TextEditingController();

  @override
  void initState() {
    ballsFacedTeam1Controller.text = widget.match.ballsFacedTeam1 == null
        ? ""
        : (widget.match.ballsFacedTeam1).toString();
    ballsFacedTeam2Controller.text = widget.match.ballsFacedTeam2 == null
        ? ""
        : (widget.match.ballsFacedTeam2).toString();
    runsTeam1Controller.text = widget.match.runsTeam1 == null
        ? ""
        : (widget.match.runsTeam1).toString();
    runsTeam2Controller.text = widget.match.runsTeam2 == null
        ? ""
        : (widget.match.runsTeam2).toString();
    numPlayesOutTeam1Controller.text = widget.match.numPlayesOutTeam1 == null
        ? ""
        : (widget.match.numPlayesOutTeam1).toString();
    numPlayesOutTeam2Controller.text = widget.match.numPlayesOutTeam2 == null
        ? ""
        : (widget.match.numPlayesOutTeam2).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Profile"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: runsTeam1Controller,
                  decoration: const InputDecoration(
                    label: Text("Runs Team 1"),
                  ),
                ),
                TextField(
                  controller: runsTeam2Controller,
                  decoration: const InputDecoration(
                    label: Text("Runs Team 2"),
                  ),
                ),
                TextField(
                  controller: ballsFacedTeam1Controller,
                  decoration: const InputDecoration(
                    label: Text("Balls faced by team 1"),
                  ),
                ),
                TextField(
                  controller: ballsFacedTeam2Controller,
                  decoration: const InputDecoration(
                    label: Text("Balls faced by team 2"),
                  ),
                ),
                TextField(
                  controller: numPlayesOutTeam1Controller,
                  decoration: const InputDecoration(
                    label: Text("Wickets lost team 1"),
                  ),
                ),
                TextField(
                  controller: numPlayesOutTeam2Controller,
                  decoration: const InputDecoration(
                    label: Text("Wickets lost team 2"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (ballsFacedTeam1Controller.text.isNotEmpty &&
                          int.tryParse(ballsFacedTeam1Controller.text) !=
                              null &&
                          ballsFacedTeam2Controller.text.isNotEmpty &&
                          int.tryParse(ballsFacedTeam2Controller.text) !=
                              null &&
                          runsTeam1Controller.text.isNotEmpty &&
                          int.tryParse(runsTeam1Controller.text) != null &&
                          runsTeam2Controller.text.isNotEmpty &&
                          int.tryParse(runsTeam2Controller.text) != null &&
                          numPlayesOutTeam1Controller.text.isNotEmpty &&
                          int.tryParse(numPlayesOutTeam1Controller.text) !=
                              null &&
                          numPlayesOutTeam2Controller.text.isNotEmpty &&
                          int.tryParse(numPlayesOutTeam2Controller.text) !=
                              null) {
                        await updateMatch(
                            widget.matchId,
                            CricketMatch(
                              widget.match.leagueId,
                              widget.match.team1Id,
                              widget.match.team2Id,
                              widget.match.dayOfMatch,
                              int.parse(ballsFacedTeam1Controller.text),
                              int.parse(ballsFacedTeam2Controller.text),
                              int.parse(runsTeam1Controller.text),
                              int.parse(runsTeam2Controller.text),
                              int.parse(numPlayesOutTeam1Controller.text),
                              int.parse(numPlayesOutTeam2Controller.text),
                            ));
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Done.")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
