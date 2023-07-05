import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:log/pages/settings.dart';

import '../controller/home_page_controller.dart';

class Homecall extends StatefulWidget {
  const Homecall({Key? key}) : super(key: key);

  @override
  State<Homecall> createState() => _HomecallState();
}

class _HomecallState extends State<Homecall> {
  final user = FirebaseAuth.instance.currentUser!;
  DocumentReference userName = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);



  String name = '';
  String surname = '';

  // List<String> docIDs = [];

  // Future getDocId() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((Document) {
  //             print(Document.reference);
  //             docIDs.add(Document.reference.id);
  //           }));
  // }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    DocumentReference authResult = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot docSnap = await authResult.get();
    var data = docSnap.data() as Map<String, dynamic>;
    name = data['First Name'];
    surname = data['last Name'];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[900],
              actions: [
                IconButton(
                  onPressed: signUserOut,
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
            body: Center(
              child: Text(
                user.email! + " olarak girildi ",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                    ),
                    child: Stack(
                      children: <Widget>[
                        //Profil foto
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(''),
                            radius: 50.0,
                          ),
                        ),

                        //İsim
                        Align(
                          alignment: const Alignment(.5, .0),
                          child: Expanded(
                            child: FutureBuilder<DocumentSnapshot>(
                              future: userName.get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Bilinmeyen Hata");
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return const Text("Hata");
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return Text(
                                    "${data['First Name']}  ${data['last Name']}",
                                    style: TextStyle(color: Colors.grey[300]),
                                  );
                                }

                                return const Text("Yükleniyor");
                              },
                            ),
                          ),
                        ),

                        //admin yada normal kullanıcı olup olmadıgı hakkında yazı belki

                        // Align(
                        //   alignment: Alignment.centerRight + const Alignment(0, .8),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.white),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //     child: const Padding(
                        //       padding: EdgeInsets.all(5.0),
                        //       child: Text(
                        //         '',
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(
                      'Ayarlar',
                      style: GoogleFonts.lexendDeca(
                        textStyle: const TextStyle(color: Colors.black),
                        fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
