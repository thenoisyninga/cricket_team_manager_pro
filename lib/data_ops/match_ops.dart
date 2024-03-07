import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/models/match_model.dart';

Future<String?> addMatchToFirestore(CricketMatch match) async {
  var db = FirebaseFirestore.instance;

  String? matchId;

  print("adding match");
  var createdDoc = await db.collection("matches").add(match.toMap());

  await createdDoc.get().then(
    (doc) {
      if (doc.data() != null) {
        matchId = doc.id;
      }
    },
  );

  return matchId;
}

Future<void> updateMatch(String matchId, CricketMatch match) async {
  var db = FirebaseFirestore.instance;

  print("updating match");
  db.collection("matches").doc(matchId).set(match.toMap());
}

Future<CricketMatch?> getMatchFromFirestore(String matchId) async {
  var db = FirebaseFirestore.instance;

  CricketMatch? match;
  Map<String, dynamic>? matchData;

  await db.collection("matches").doc(matchId).get().then((doc) {
    if (doc.data() != null) {
      matchData = doc.data() as Map<String, dynamic>;
    }
  });

  match = CricketMatch.fromMap(matchData!);

  return match;
}
