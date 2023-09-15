// //import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// //import 'package:get/get.dart';
// //import 'package:get/get_core/src/get_main.dart';
// //import 'package:music2/models/song_model.dart';
// import 'package:bpgc_pawn_shop/Model/item_model.dart';

// class ItemCard extends StatelessWidget {
//   const ItemCard({
//     super.key,
//     required this.item,
//   });

//   final Item item;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         //Get.toNamed('/song', arguments:song);
//       },
//       child: Container(
//         margin: const EdgeInsets.only(right: 10),
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children:[
//             Container(
//               width: MediaQuery.of(context).size.width * 0.45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                   image: AssetImage(
//                     //item.imagePath
//                   ),
//                       fit : BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//               height: 50,
//               width: MediaQuery.of(context).size.width * 0.45,
//               margin: const EdgeInsets.only(bottom: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.white.withOpacity(0.8),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.title,
//                         style: const TextStyle(
//                           color: Colors.deepPurple,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18.0
//                         ),
//                       ),
//                       Text(
//                         item.description,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 8.0
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Icon(
//                     Icons.play_circle,
//                     color: Colors.deepPurple,
//                   )
//                 ],
//               ),
//             ),
//           ]
//         ),
//       ),
//     );
//   }
// }


