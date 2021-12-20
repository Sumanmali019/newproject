// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:location_tracker/screens/camera_upload.dart';
// import 'package:location_tracker/screens/loginin.dart';
// import 'package:location_tracker/screens/showuploads.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final _auth = FirebaseAuth.instance;
//   final _number = FirebaseAuth.instance.currentUser!.phoneNumber;
//   User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(225, 232, 237, 0.8),
//         appBar: AppBar(
//           elevation: 0,
//           actions: <Widget>[
//             IconButton(
//                 onPressed: () async {
//                   await _auth.signOut();
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const Loginscreen()));
//                 },
//                 icon: const Icon(Icons.logout_outlined))
//           ],
//           backgroundColor: const Color.fromRGBO(7, 84, 94, 0.9),
//           title: Text('Welcome $_number'),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: <Widget>[
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(top: 20, left: 80, bottom: 20),
//                   margin: const EdgeInsets.only(left: 70),
//                   height: MediaQuery.of(context).size.height / 5,
//                   width: MediaQuery.of(context).size.width / 2,
//                   //  margin: const EdgeInsets.symmetric(horizontal: 10),
//                   child: InkWell(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 100,
//                       alignment: Alignment.center,
//                       child: const Icon(
//                         Icons.camera_alt,
//                         color: Color.fromRGBO(7, 84, 95, 0.9),
//                         size: 100,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade400,
//                         border: Border.all(width: 8, color: Colors.black12),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CameraUpload(
//                                   userId:
//                                       FirebaseAuth.instance.currentUser!.uid)));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 2.0),
//               child: Container(
//                 padding: const EdgeInsets.only(top: 20, left: 80, bottom: 20),
//                 margin: const EdgeInsets.only(right: 65),
//                 height: MediaQuery.of(context).size.height / 5,
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: InkWell(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 100,
//                     alignment: Alignment.center,
//                     child: const Icon(
//                       Icons.image,
//                       color: Color.fromRGBO(7, 84, 95, 0.9),
//                       size: 100,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade400,
//                       border: Border.all(width: 8, color: Colors.black12),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Showuploads(
//                                   userId:
//                                       FirebaseAuth.instance.currentUser!.uid,
//                                 )));
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
