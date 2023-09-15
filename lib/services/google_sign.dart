//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  signInGoogle() async{
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);

  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:get/get.dart';

// class AuthService {
//   Future<UserCredential?> signInGoogle() async {
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     if (gUser == null) {
//       return null; // Sign-in with Google was canceled
//     }

//     final GoogleSignInAuthentication gAuth = await gUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     try {
//       final userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       // Navigate to the home page on successful Google sign-in
//       Get.offAll(() => HomePage());

//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       // Handle any authentication errors if needed
//       print("Error signing in with Google: ${e.message}");
//       return null;
//     }
//   }
// }
