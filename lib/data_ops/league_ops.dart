import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';

Future<String?> addLeagueToFirestore(League league) async {
  var db = FirebaseFirestore.instance;

  String? leagueId;

  print("adding league");
  var createdDoc = await db.collection("leagues").add(league.toMap());

  await createdDoc.get().then(
    (doc) {
      if (doc.data() != null) {
        leagueId = doc.id;
      }
    },
  );

  return leagueId;
}

Future<void> updateLeague(String leagueId, League league) async {
  var db = FirebaseFirestore.instance;

  print("updating league");
  db.collection("leagues").doc(leagueId).set(league.toMap());
}

Future<League?> getLeagueFromFirestore(String leagueId) async {
  var db = FirebaseFirestore.instance;

  League? league;
  Map<String, dynamic>? leagueData;

  await db.collection("leagues").doc(leagueId).get().then((doc) {
    if (doc.data() != null) {
      leagueData = doc.data() as Map<String, dynamic>;
    }
  });

  league = League.fromMap(leagueData!);

  return league;
}
