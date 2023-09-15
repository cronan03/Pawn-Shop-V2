import 'dart:async';

//import 'package:bpgc_pawn_shop/pages/home_pg.dart';
//import 'package:bpgc_pawn_shop/pages/auth_pg.dart';
import 'package:bpgc_pawn_shop/pages/login_pg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
  
    super.initState();

    Timer(const Duration(seconds: 5), () { 
      Get.off(() =>  const LoginPage());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[600],
        child: Center(
          child: Lottie.asset(
            'assets/money.json',
            repeat: true,
            reverse: false,
            height: 300,
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}