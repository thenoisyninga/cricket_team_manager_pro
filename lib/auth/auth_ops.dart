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

    return "success";
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    print(e);
    return "failed";
  }
}

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
