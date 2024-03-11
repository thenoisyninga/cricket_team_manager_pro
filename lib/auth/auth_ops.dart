import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> loginWithEmailAndPassword(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return "success";
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    print(e);
    return "failed";
  }
}

Future<String?> signUpWithEmailAndPassword(
    String email, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // TODO Populate with default data
    addPlayerToFirestore(Player.fromDefault());

    return "success";
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    print(e);
    return "failed";
  }
}

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken!.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }

// signInWithGoogle() async {
//   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//   final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: gAuth.accessToken,
//     idToken: gAuth.idToken,
//   );

//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

Future<String?> logout() async {
  try {
    final credential = await FirebaseAuth.instance.signOut();

    return "success";
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    print(e);
    return "failed";
  }
}

Future<User?> getCurrentUser() async {
  User? userToReturn;
  await FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      userToReturn = user;
    }
  });

  return userToReturn;
}
