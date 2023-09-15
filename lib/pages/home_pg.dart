import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query the users collection to get all cards from all users
      QuerySnapshot cardsSnapshot = await usersCollection.get();

      List<Item> fetchedItems = [];

      for (QueryDocumentSnapshot userDoc in cardsSnapshot.docs) {
        QuerySnapshot userCardsSnapshot = await userDoc.reference.collection('cards').get();

        for (QueryDocumentSnapshot cardDoc in userCardsSnapshot.docs) {
          // Extract card data and create an Item object
          Item item = Item(
            title: cardDoc['title'],
            description: cardDoc['description'],
            price: cardDoc['price'],
            negotiable: cardDoc['isNegotiable']
          );

          fetchedItems.add(item);
        }
      }

      setState(() {
        items = fetchedItems; // Update the list of items
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
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:const  CustomAppBar(),
        bottomNavigationBar: const CustomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Sometext(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Text(
                        "Most Viewed",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 21, 3, 42),
                          fontSize: 20
                        ),
                      ),
                    ),
                    //const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height*0.50,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, index){
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

