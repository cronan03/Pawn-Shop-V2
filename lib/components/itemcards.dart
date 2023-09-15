//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
//import 'package:music2/models/song_model.dart';
import 'package:bpgc_pawn_shop/Model/item_model.dart';


class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },

      child: Stack(
        children: [
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 114, 61, 220),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/fp1.jpeg', //input image ????
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Item Details (right side)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title, 
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ ${item.price.toStringAsFixed(2)}', 
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 5, 5),
                            fontWeight: FontWeight.bold,
                            backgroundColor: Color.fromARGB(255, 212, 18, 187),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.description, 
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (item.negotiable) // Show negotiable label if negotiable is true
            Positioned(
              top: 10,
              right: 10,
              child: Transform.rotate(
                angle: -0.25,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Negotiable',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


