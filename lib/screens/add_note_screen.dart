import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatelessWidget {
  String? title;
  String? des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF3F4E4F),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF2C3639),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                        color: Color(0xFFA27B5C),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => add(context),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF2C3639),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFA27B5C),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: Color(0xFFDCD7C9),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDCD7C9),
                        ),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: const InputDecoration.collapsed(
                            hintText: "Nota Descpription",
                            hintStyle: TextStyle(
                              color: Color(0xFFDCD7C9),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFFDCD7C9),
                          ),
                          onChanged: (val) {
                            des = val;
                          },
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // add nota to firebase
  void add(BuildContext ctx) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');
    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };
    if (title == null || des == null) {
      if (kDebugMode) {
        print('title and descpreption by null');
      }
      Navigator.pop(ctx);
    }
    ref.add(data);
    Navigator.pop(ctx);
  }
}
