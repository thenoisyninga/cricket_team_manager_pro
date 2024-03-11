import 'package:cricket_team_manager_pro/data_ops/match_ops.dart';
import 'package:cricket_team_manager_pro/pages/match/match_display.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatefulWidget {
  const MatchTile({super.key, required this.matchId});

  final String matchId;

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMatchTeams(widget.matchId),
        builder: (context, snapshot) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchDisplay(
                    matchId: widget.matchId,
                  ),
                ),
              );
            },
            tileColor: Colors.red,
            title: snapshot.hasData
                ? Text("${snapshot.data![0]} vs ${snapshot.data![1]} ")
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }
}
