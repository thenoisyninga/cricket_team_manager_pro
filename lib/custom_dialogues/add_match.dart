import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/custom_dialogues/select_player.dart';
import 'package:cricket_team_manager_pro/data_ops/linked_ops/linked_ops_match.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';
import 'package:cricket_team_manager_pro/models/match_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMatchDialogue extends StatefulWidget {
  const AddMatchDialogue({super.key, required this.leagueId});

  final String leagueId;

  @override
  State<AddMatchDialogue> createState() => _AddMatchDialogueState();
}

class _AddMatchDialogueState extends State<AddMatchDialogue> {
  DateTime? dayOfMatch;
  TextEditingController team1NameController = TextEditingController();
  TextEditingController team2NameController = TextEditingController();
  String searchQuery = "";
  String? team1Id;
  String? team2Id;

  @override
  void initState() {
    dayOfMatch = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Match'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            // Select Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                        barrierColor: Colors.grey[900],
                        context: context,
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2050));

                    if (selectedDate != null) {
                      setState(() {
                        dayOfMatch = selectedDate;
                      });
                    }
                  },
                  child: const Text("Set Match Date"),
                ),
                Text(dayOfMatch.toString().substring(0, 10)),
              ],
            ),

            // Select Team 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select Team'),
                        content: SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                TextField(
                                  controller: team1NameController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        print("called");
                                        setState(() {
                                          searchQuery =
                                              team1NameController.text;
                                        });
                                      },
                                      icon: const Icon(Icons.search),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection("teams")
                                          .where("name",
                                              isGreaterThanOrEqualTo:
                                                  searchQuery)
                                          .where(
                                            "name",
                                            isLessThanOrEqualTo:
                                                '$searchQuery\uf8ff',
                                          )
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView(
                                            children:
                                                snapshot.data!.docs.map((doc) {
                                              return ListTile(
                                                onTap: () {
                                                  team1Id = doc.id;
                                                  Navigator.pop(context);
                                                },
                                                title: Text(
                                                  doc.data()["name"],
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                subtitle: Text(
                                                  "${doc.data()["teamPlayerIds"].length} members",
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  child: const Text("Select Team 1"),
                ),
                team1Id != null
                    ? FutureBuilder(
                        future: getTeamFromFirestore(team1Id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.name);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          ;
                        })
                    : const SizedBox(),
              ],
            ),

            // Select Team 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select Team'),
                        content: SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                TextField(
                                  controller: team1NameController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        print("called");
                                        setState(() {
                                          searchQuery =
                                              team1NameController.text;
                                        });
                                      },
                                      icon: const Icon(Icons.search),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection("teams")
                                          .where("name",
                                              isGreaterThanOrEqualTo:
                                                  searchQuery)
                                          .where(
                                            "name",
                                            isLessThanOrEqualTo:
                                                '$searchQuery\uf8ff',
                                          )
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView(
                                            children:
                                                snapshot.data!.docs.map((doc) {
                                              return ListTile(
                                                onTap: () {
                                                  team2Id = doc.id;
                                                  Navigator.pop(context);
                                                },
                                                title: Text(
                                                  doc.data()["name"],
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                subtitle: Text(
                                                  "${doc.data()["teamPlayerIds"].length} members",
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  child: const Text("Select Team 2"),
                ),
                team2Id != null
                    ? FutureBuilder(
                        future: getTeamFromFirestore(team2Id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.name);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })
                    : const SizedBox(),
              ],
            ),
            // Add Match Button
            ElevatedButton(
              onPressed: () {
                if (dayOfMatch != null && team1Id != null && team2Id != null) {
                  createMatch(
                    CricketMatch(
                      widget.leagueId,
                      team1Id!,
                      team2Id!,
                      dayOfMatch!,
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                    ),
                    widget.leagueId,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add Match"),
            )
          ],
        ),
      ),
    );
  }
}
