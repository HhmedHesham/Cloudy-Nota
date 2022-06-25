import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudy_nota/screens/add_note_screen.dart';
import 'package:cloudy_nota/screens/note_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // user notes by uid
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color?> notesColor = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
    Colors.purple[200],
    Colors.cyan[200],
    Colors.teal[200],
    Colors.tealAccent[200],
    Colors.pink[200],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F4E4F),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
            setState(() {});
          });
        },
        backgroundColor: const Color(0xFF2C3639),
        child: const Icon(
          Icons.add,
          color: Color(0xFFA27B5C),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3639),
        elevation: 0,
        title: const Text(
          "Notes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFDCD7C9),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Notes in ur Nota yet!",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 12 / 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map? data = snapshot.data!.docs[index].data() as Map;
                  String formattedTime = DateFormat.yMMMd()
                      .add_jm()
                      .format(data['created'].toDate());
                  Color? randomColor =
                      notesColor[Random().nextInt(notesColor.length)];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => NoteDetailsScreen(
                            data: data,
                            time: formattedTime,
                            ref: snapshot.data!.docs[index].reference,
                          ),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: randomColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3639),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFFDCD7C9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
