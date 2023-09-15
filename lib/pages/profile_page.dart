import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'login_pg.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getUserEmail() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      return user.email;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserEmail(),
      builder: (context, emailSnapshot) {
        if (emailSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (emailSnapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Center(child: Text('Error: ${emailSnapshot.error}')),
          );
        } else if (emailSnapshot.data == null) {
          // User is not signed in, show a sign-in page or redirect to a sign-in page
          return Scaffold(
            appBar: AppBar(title: Text('Sign In')),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  
                  Get.off(() =>LoginPage());
                },
                child: Text('Sign In'),
              ),
            ),
          );
        } else {
          final String userEmail = emailSnapshot.data!;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: userEmail)
                .get()
                .then((querySnapshot) {
              if (querySnapshot.docs.isNotEmpty) {
                return querySnapshot.docs[0].reference.get();
              } else {
                throw Exception('User data not found');
              }
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  appBar: AppBar(title: Text('Profile')),
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(title: Text('Profile')),
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return Scaffold(
                  appBar: AppBar(title: Text('Profile')),
                  body: Center(child: Text('User data not found')),
                );
              } else {
                final data = snapshot.data!;
                final name = data.get('name') as String?;
                final phoneNo = data.get('phoneNo') as String?;
                final id = data.get('id') as String?;
                final roomNo = data.get('roomNo') as String?;

                return Scaffold(
                  appBar: AppBar(title: Text('Profile')),
                  body: Card(
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${name ?? "N/A"}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Email: ${userEmail}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Phone No.: ${phoneNo ?? "N/A"}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('ID: ${id ?? "N/A"}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Room No.: ${roomNo ?? "N/A"}', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
