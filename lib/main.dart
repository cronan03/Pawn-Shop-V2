import 'package:bpgc_pawn_shop/pages/home_pg.dart';
import 'package:bpgc_pawn_shop/pages/login_pg.dart';
import 'package:bpgc_pawn_shop/pages/profile_page.dart';
import 'package:bpgc_pawn_shop/pages/register_pg.dart';
//import 'package:bpgc_pawn_shop/pages/sellpage.dart';
import 'package:bpgc_pawn_shop/pages/sellpage2.dart';
///import 'package:bpgc_pawn_shop/pages/splash.dart';
import 'package:bpgc_pawn_shop/pages/user_info.dart';
import 'package:flutter/material.dart';
//import 'pages/login_pg.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'controllers/user_controller.dart';
import 'firebase_options.dart';
//import 'pages/auth_pg.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BPGC Pawn Shop",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      //home: const SplashScreen(),
      // initialBinding: BindingsBuilder(() {
      //   Get.put(UserController());
      //}),
      initialRoute: '/',
       getPages: [
         GetPage(name: '/', page: () =>  HomePage()),
         GetPage(name: '/login', page: () => const LoginPage()),
         GetPage(name: '/register', page: () => const RegisterPage()),
         GetPage(name: '/hm', page: () =>  HomePage()),
         GetPage(name: '/userinfo', page: () =>  UserInfo()),
         GetPage(name: '/sellpg', page: () =>  SellPage2()),
         GetPage(name: '/prof', page: () =>  ProfilePage()),
       ],
    );
  }
}