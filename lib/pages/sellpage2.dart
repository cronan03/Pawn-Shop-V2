import 'package:bpgc_pawn_shop/pages/home_pg.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/navigationbar.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


class SellPage2 extends StatefulWidget {
  @override
  _SellPage2State createState() => _SellPage2State();
}

class _SellPage2State extends State<SellPage2> {

 // DatabaseReference ref = FirebaseDatabase.instance.ref("cards");

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isNegotiable = false;

  int currentStep = 0;
  List<Step> steps = [];

  @override
  void initState() {
    //submitProductData();
    super.initState();
    steps = [
      Step(
        title: Text('Product Title'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Enter Product Title'),
        ),
        isActive: true,
      ),
      Step(
        title: Text('Product Price'),
        content: TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Enter Product Price'),
        ),
        isActive: true,
      ),
      Step(
        title: Text('Product Description'),
        content: TextField(
          controller: descriptionController,
          maxLines: 3,
          decoration: InputDecoration(labelText: 'Enter Product Description'),
        ),
        isActive: true,
      ),
    ];
    _getUserEmail();
  }
  
  Future<void> _getUserEmail() async {
    String? userEmail = await getUserEmail();
    if (userEmail != null) {
      
      setState(() {});
    }
  }

  Future<String?> getUserEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    if (user != null) {
      return user.email;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Page'),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: ListView(
        children: [
         
          Stepper(
            currentStep: currentStep,
            steps: steps,
            onStepContinue: () {
              if (currentStep < steps.length - 1) {
                setState(() {
                  currentStep += 1;
                });
              } else {
                // Submit the data to Firestore
                submitProductData();
              }
            },
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
          ),
           SizedBox(height: 16),
          SwitchListTile(
            title: Text('Negotiable?'),
            value: isNegotiable,
            onChanged: (value) {
              setState(() {
                isNegotiable = value;
              });
            },
          ),
        ],
      ),
    );
  }

 void submitProductData() async {
  // Upload the data to Cloud Firestore
  String title = titleController.text;
  double price = double.tryParse(priceController.text) ?? 0.0;
  String description = descriptionController.text;

  
  String? userEmail = await getUserEmail(); 
  

  try  {
    
    // CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    // QuerySnapshot userSnapshot = await usersCollection.where('email', isEqualTo: userEmail).get();

    // if (userSnapshot.docs.length == 1) {
    //   String userDocId = userSnapshot.docs[0].id;
    //   CollectionReference cardsCollection = usersCollection.doc(userDocId).collection('cards');

    //   // Create a new document in the "cards" collection
    //   await cardsCollection.add({
    //     'title': title,
    //     'price': price,
    //     'description': description,
    //     'isNegotiable': isNegotiable,
    //   });
      //final FirebaseDatabase database = FirebaseDatabase(
      //databaseURL: 'https://bpgc-pawn-shop-default-rtdb.asia-southeast1.firebasedatabase.app',
//);
      final firebaseApp = Firebase.app();
      final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://bpgc-pawn-shop-default-rtdb.asia-southeast1.firebasedatabase.app');
      //DatabaseReference ref = FirebaseDatabase.instance.ref("cards");
      //DatabaseReference ref = rtdb.ref().child("cards");
      //DatabaseReference card = ref.push();


      final card = <String, dynamic>{
        "title": title,
        "price": price,
        "description": description,
        "isNegotiable": isNegotiable,
        "email" : userEmail,
      };
      rtdb.ref().child("cards").push().set(card);
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Data submitted successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(() => HomePage());
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } 
   catch (e) {
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to submit user data. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

}