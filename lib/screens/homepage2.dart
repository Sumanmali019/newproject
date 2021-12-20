import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/screens/camera_upload.dart';
import 'package:location_tracker/loginscreen/loginin.dart';
import 'package:location_tracker/screens/loctaiontrack.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _auth = FirebaseAuth.instance;
  final _number = FirebaseAuth.instance.currentUser!.phoneNumber;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(225, 232, 237, 0.8),
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Loginscreen()));
                },
                icon: const Icon(Icons.logout_outlined))
          ],
          backgroundColor: const Color.fromRGBO(7, 84, 94, 0.9),
          title: Text('Welcome $_number'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 80, bottom: 20),
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 1,
                  child: InkWell(
                    child: Container(
                      // width: 100,
                      // // height: 200,
                      alignment: Alignment.center,
                      child: const Image(
                        image: AssetImage('assets/images/camera.png'),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraUpload(
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid)));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: const Text(
                  'Map',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: InkWell(
                  child: Container(
                    width: 100,
                    height: 200,
                    alignment: Alignment.center,
                    child: const Image(
                        image: AssetImage(
                            'assets/images/icons8-google-maps-old-480.png')),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Location()));
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('images')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return (const Center(child: Text('no images')));
                    } else {
                      return FractionallySizedBox(
                        heightFactor: 0.4,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, int index) {
                            String url =
                                snapshot.data!.docs[index]["downloadUrl"];
                            if (snapshot.hasData) {
                              return FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Container(
                                  margin: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        url,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
