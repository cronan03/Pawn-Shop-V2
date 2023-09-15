

import 'package:bpgc_pawn_shop/pages/home_pg.dart';
import 'package:bpgc_pawn_shop/pages/loading.dart';
import 'package:bpgc_pawn_shop/pages/login_pg.dart';
//import 'package:bpgc_pawn_shop/pages/sellpage.dart';
import 'package:bpgc_pawn_shop/pages/users_pg.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:bpgc_pawn_shop/pages/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../pages/profile_page.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple.shade800,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Favourites',
          activeIcon: Icon(Icons.people_outline),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sell),
          label: 'Sell',
          activeIcon: Icon(Icons.sell),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          activeIcon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout_outlined),
          label: 'LogOut',
          activeIcon: Icon(Icons.logout_outlined),
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            // Handle Home button tap
            Get.to(() =>HomePage());
            break;
          case 1:
            // Handle Favourites button tap
            Get.to(() =>UsersPage());
            break;
          case 2:
            // Handle Sell button tap
            Get.to(() =>Loading(rt: '/sellpg'));
            break;
          case 3:
            // Handle Profile button tap
            Get.to(() => Loading(rt: '/prof'));
            break;
          case 4:
            // Handle LogOut button tap
            FirebaseAuth.instance.signOut();
            Get.off(() =>LoginPage());
            break;
        }
      },
    );
  }
}
