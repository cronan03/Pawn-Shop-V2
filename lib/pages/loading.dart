import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

//import 'login_pg.dart';

class Loading extends StatefulWidget {
 final  String rt;
 const Loading({super.key, required this.rt});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override

void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 2), () { 
      Get.offAndToNamed(widget.rt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[600],
        child: Center(
          child: Lottie.asset(
            'assets/load2.json',
            repeat: true,
            reverse: false,
            height: 150,
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}