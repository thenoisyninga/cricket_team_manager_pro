import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/linked_ops/linked_ops_team.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/custom_dialogues/view_team_leagues.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:cricket_team_manager_pro/pages/player/player_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeamDisplay extends StatefulWidget {
  const TeamDisplay({super.key, required this.teamId});

  final String teamId;

  @override
  State<TeamDisplay> createState() => _TeasDisplayState();
}

class _TeasDisplayState extends State<TeamDisplay> {
  String searchQuery = "";
  TextEditingController playerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTeamFromFirestore(widget.teamId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Team team = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text("T E A M"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      AutoSizeText(
                        team.name,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // League
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ViewTeamLeaguesDialogue(
                                  teamId: widget.teamId,
                                ),
                              );
                            },
                            child: const Text(
                              "See Leagues",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Players List
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Team Players: ",
                            style: TextStyle(),
                          ),
                          FutureBuilder(
                              future: isTeamCaptian(widget.teamId),
                              builder: (
                                context,
                                snapshot,
                              ) {
                                if (snapshot.hasData) {
                                  return team.teamPlayerIds.length < 12
                                      ? !snapshot.data!
                                          ? TextButton(
                                              onPressed: () async {
                                                print("pressed");
                                                User? user =
                                                    await getCurrentUser();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                                addPlayerToTeam(
                                                  user!.uid,
                                                  widget.teamId,
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Join"))
                                          : IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                        'Select Player'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                        child: Column(
                                                          children: [
                                                            TextField(
                                                              controller:
                                                                  playerNameController,
                                                              decoration:
                                                                  InputDecoration(
                                                                suffixIcon:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        "called");
                                                                    setState(
                                                                        () {
                                                                      searchQuery =
                                                                          playerNameController
                                                                              .text;
                                                                    });
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .search),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.8,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              child:
                                                                  FutureBuilder(
                                                                      future: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "players")
                                                                          .where(
                                                                              "firstName",
                                                                              isGreaterThanOrEqualTo:
                                                                                  searchQuery)
                                                                          .where(
                                                                            "firstName",
                                                                            isLessThanOrEqualTo:
                                                                                '$searchQuery\uf8ff',
                                                                          )
                                                                          .get(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return ListView(
                                                                            children:
                                                                                snapshot.data!.docs.map((doc) {
                                                                              return ListTile(
                                                                                onTap: () async {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (context) => const Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    ),
                                                                                    barrierDismissible: false,
                                                                                  );

                                                                                  await addPlayerToTeam(
                                                                                    doc.id,
                                                                                    widget.teamId,
                                                                                  );
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                title: Text(
                                                                                  doc.data()["firstName"] + doc.data()["lastName"],
                                                                                  style: const TextStyle(fontSize: 20),
                                                                                ),
                                                                                // subtitle: Text(
                                                                                //   "${doc.data()["teamPlayerIds"].length} members",
                                                                                //   style: TextStyle(
                                                                                //       color: Colors
                                                                                //               .grey[
                                                                                //           400]),
                                                                                // ),
                                                                              );
                                                                            }).toList(),
                                                                          );
                                                                        } else {
                                                                          return const Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          );
                                                                        }
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ).then(
                                                    (value) => setState(() {}));
                                              },
                                              icon: const Icon(Icons.add),
                                            )
                                      : const SizedBox();
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Color.fromARGB(255, 44, 44, 44),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView(
                              children: team.teamPlayerIds
                                  .map((playerId) => FutureBuilder(
                                      future: getPlayerFromFirestore(playerId),
                                      builder: (context, snapshot) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileView(
                                                          playerId: playerId),
                                                ));
                                          },
                                          title: snapshot.hasData
                                              ? Text(
                                                  "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                              : const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                        );
                                      }))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // Batting LineUp
                      Text(
                        "Batting lineup: ",
                        style: TextStyle(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Color.fromARGB(255, 44, 44, 44),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView(
                              children: team.battingLineup
                                  .map((playerId) => FutureBuilder(
                                      future: getPlayerFromFirestore(playerId),
                                      builder: (context, snapshot) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileView(
                                                          playerId: playerId),
                                                ));
                                          },
                                          title: snapshot.hasData
                                              ? Text(
                                                  "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                              : const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                        );
                                      }))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // Bowling LineUp
                      Text(
                        "Bowling lineup: ",
                        style: TextStyle(),
                      ),
                      Container(
                        color: Color.fromARGB(255, 44, 44, 44),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView(
                          children: team.bowlingLineup
                              .map((playerId) => FutureBuilder(
                                  future: getPlayerFromFirestore(playerId),
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProfileView(
                                                  playerId: playerId),
                                            ));
                                      },
                                      title: snapshot.hasData
                                          ? Text(
                                              "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    );
                                  }))
                              .toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
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
      },
    );
  }
}
