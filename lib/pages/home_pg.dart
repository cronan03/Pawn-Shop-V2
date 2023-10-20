//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bpgc_pawn_shop/components/stuffonhome.dart';

import '../Model/item_model.dart';
import '../components/itemcards.dart';
import '../components/navigationbar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method cronan@gmail.com 1234lol
  List<Item> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    try {
      final firebaseApp = Firebase.app();
      final rtdb = FirebaseDatabase.instanceFor(
          app: firebaseApp,
          databaseURL:
              'https://bpgc-pawn-shop-default-rtdb.asia-southeast1.firebasedatabase.app');
      DatabaseReference databaseRef = rtdb.ref().child("cards");
      debugPrint("working");
      // Listen for changes in the database
      databaseRef.onValue.listen((DatabaseEvent event) {
        // Get the data snapshot
        DataSnapshot snapshot = event.snapshot;

        List<Item> fetchedItems = [];

        // Check if the snapshot value is not null before iterating
        if (snapshot.value != null && snapshot.value is Map<String, dynamic>) {
          // Cast snapshot.value to Map<String, dynamic> for iteration
          // Map<String, dynamic> cardDataMap =
          //     snapshot.value as Map<String, dynamic>;

          for (final child in event.snapshot.children) {
            Map<String, dynamic>? itemData = child.value
                as Map<String, dynamic>?; // Cast to Map<String, dynamic>?

            if (itemData != null) {
              // Check for nullability
              Item item = Item(
                title: itemData['title'],
                description: itemData['description'],
                price: itemData['price'],
                negotiable: itemData['isNegotiable'],
              );
              fetchedItems.add(item);
            }
          }

          // Iterate through each child node (cards)
          // cardDataMap.forEach((key, cardData) {
          //   // Create an Item object from the cardData
          //   Item item = Item(
          //     title: cardData['title'],
          //     description: cardData['description'],
          //     price: cardData['price'],
          //     negotiable: cardData['isNegotiable'],
          //   );

          //   fetchedItems.add(item);
          // });
        }
        setState(() {
          items = fetchedItems; // Update the list of items
        });
      });
    } catch (e) {
      // Handle error
      print('Error fetching items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800,
            Colors.deepPurple.shade200
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(),
        bottomNavigationBar: const CustomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Sometext(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Text(
                        "Most Viewed",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 21, 3, 42),
                            fontSize: 20),
                      ),
                    ),
                    //const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ItemCard(item: items[index]);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
