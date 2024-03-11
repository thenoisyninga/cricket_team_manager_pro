import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addPlayerToFirestore(Player player) async {
  var db = FirebaseFirestore.instance;

  User? user = await getCurrentUser();

  if (user != null) {
    print("adding");
    db.collection("players").doc(user.uid).set(player.toMap());
  } else {
    print("user null");
  }
}

Future<Player?> getCurrentPlayerFromFirestore() async {
  var db = FirebaseFirestore.instance;

  User? user = await getCurrentUser();
  Player? player;

  if (user != null) {
    await db.collection("players").doc(user.uid).get().then((doc) {
      if (doc.data() != null) {
        player = Player.fromMap((doc.data()!));
      }
    });
  }
  return player;
}

Future<Player?> getPlayerFromFirestore(String playerId) async {
  var db = FirebaseFirestore.instance;
  Player? player;

  await db.collection("players").doc(playerId).get().then((doc) {
    if (doc.data() != null) {
      player = Player.fromMap((doc.data()!));
    }
  });

  return player;
}

Future<void> updatePlayer(String playerId, Player player) async {
  var db = FirebaseFirestore.instance;

  print("updating player");
  db.collection("players").doc(playerId).set(player.toMap());
}
