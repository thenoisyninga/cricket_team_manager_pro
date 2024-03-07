import 'package:flutter/material.dart';

class TeamDisplay extends StatefulWidget {
  const TeamDisplay({super.key});

  @override
  State<TeamDisplay> createState() => _TeasDisplayState();
}

class _TeasDisplayState extends State<TeamDisplay> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("teams list"),
      ),
    );
  }
}
