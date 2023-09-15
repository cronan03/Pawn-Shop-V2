import 'package:bpgc_pawn_shop/pages/login_pg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:lib/pages/login_pg.dart';
import 'home_pg.dart';
//import 'login_pg.dart';
//import 'reg_log.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            Get.offAll(() => HomePage());
          }

          // user is NOT logged in
          else {
            Get.offAll(() => const LoginPage());
          }
          return Container();
        },
      ),
    );
  }
}