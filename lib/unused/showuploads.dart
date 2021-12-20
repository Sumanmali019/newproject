// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class Showuploads extends StatefulWidget {
//   String? userId;

//   Showuploads({Key? key, this.userId}) : super(key: key);

//   @override
//   _ShowuploadsState createState() => _ShowuploadsState();
// }

// class _ShowuploadsState extends State<Showuploads> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color.fromRGBO(7, 84, 94, 0.9),
//         title: const Text('Uploaded images'),
//         centerTitle: true,
//       ),
//       backgroundColor: const Color.fromRGBO(225, 232, 237, 0.8),
//       body: Container(
//         alignment: Alignment.center,
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(FirebaseAuth.instance.currentUser!.uid)
//               .collection('images')
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return (const Center(child: Text('no images')));
//             } else {
//               return FractionallySizedBox(
//                 heightFactor: 0.7,
//                 child: PageView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   onPageChanged: (int page) {
//                     setState(() {});
//                   },
//                   itemBuilder: (context, int index) {
//                     String url = snapshot.data!.docs[index]["downloadUrl"];
//                     return FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         margin: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               spreadRadius: 5,
//                               blurRadius: 10,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               url,
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
// //     return Scaffold(
// //       backgroundColor: const Color.fromRGBO(225, 232, 237, 0.8),
// //       appBar: AppBar(
// //         backgroundColor: const Color.fromRGBO(7, 84, 94, 0.9),
// //         title: const Text('uploaded images'),
// //         centerTitle: true,
// //       ),
// //       body: StreamBuilder(
// //           stream: FirebaseFirestore.instance
// //               .collection('users')
// //               .doc(FirebaseAuth.instance.currentUser!.uid)
// //               .collection('images')
// //               .snapshots(),
// //           builder:
// //               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //             if (!snapshot.hasData) {
// //               return (const Center(child: Text('no images')));
// //             } else {
// //               return PageView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: snapshot.data!.docs.length,
// //                 itemBuilder: (BuildContext context, int index) {
// //                   String url = snapshot.data!.docs[index]["downloadUrl"];
// //                   return Image.network(
// //                     url,
// //                     width: 50,
// //                     height: 50,
// //                     fit: BoxFit.fitHeight,
// //                   );
// //                 },
// //               );
// //             }
// //         }),
// //     );
// //   }
// // }

