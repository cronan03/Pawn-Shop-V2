
//import 'package:bpgc_pawn_shop/pages/profile_page.dart';

import 'package:bpgc_pawn_shop/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/navigationbar.dart';
import '../controllers/user_controller.dart';




class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController roomNoController = TextEditingController();

  int currentStep = 0;
  List<Step> steps = [];

  @override
  void initState() {
    super.initState();
    steps = [
      Step(
        title: Text('Name'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Enter your name'),
        ),
        isActive: true,
      ),
      Step(
        title: Text('Email'),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: 'Enter your email'),
        ),
        isActive: true,
      ),
      Step(
        title: Text('Phone No.'),
        content: TextField(
          controller: phoneNoController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: 'Enter your phone number'),
        ),
        isActive: true,
      ),
      Step(
        title: Text('ID'),
        content: TextField(
          controller: idController,
          decoration: InputDecoration(labelText: 'Enter your ID'),
        ),
        isActive: true,
      ),
      Step(
        title: Text('Room No.'),
        content: TextField(
          controller: roomNoController,
          decoration: InputDecoration(labelText: 'Enter your room number'),
        ),
        isActive: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input Form'),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: Stepper(
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
    );
  }
  

// ... Your existing code ...


  // Your existing code...

  void submitProductData() async {
    try {
      // Get the values from the controllers
      String name = nameController.text;
      String email = emailController.text;
      String phoneNo = phoneNoController.text;
      String id = idController.text;
      String roomNo = roomNoController.text;

      // Create a map to represent the data
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'id': id,
        'roomNo': roomNo,
      };

      // Access the Firestore instance and add the data to the "users" collection
      await FirebaseFirestore.instance.collection('users').add(userData);

      // Show a success message or perform any other actions after successful submission
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User data submitted successfully!'),
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
    //   Get.find<UserController>().setUser(
    //   name: nameController.text,
    //   email: emailController.text,
    //   phoneNo: phoneNoController.text,
    //   id: idController.text,
    //   roomNo: roomNoController.text,
    // );

    // Navigate to the ProfilePage
    Get.to(() => ProfilePage());
    } catch (e) {
      // Handle any errors that might occur during submission
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



