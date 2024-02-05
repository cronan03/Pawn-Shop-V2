// Assume this is in your Flutter app

import 'package:bpgc_pawn_shop/Database/add.dart';

void example() {
  // Create a demo user
  Map<String, dynamic> demoUserData = {
    'name': 'Demo User',
    'email': 'demo@example.com',
    'phoneNo': '123-456-7890',
    'waNo': '9876543210',
    'hostelName': 'Demo Hostel',
    'roomNo': '101',
  };

  // Use the function to add the user data to the server
  addUserDataToServer(demoUserData);
}
