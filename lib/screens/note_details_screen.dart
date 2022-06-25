import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Map? data;
  final String? time;
  final DocumentReference? ref;

  const NoteDetailsScreen({this.data, this.time, this.ref});

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  String? title;
  String? des;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data!['title'];
    des = widget.data!['description'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF3F4E4F),
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                backgroundColor: const Color(0xFF2C3639),
                child: const Icon(
                  Icons.save_rounded,
                  color: Color(0xFFA27B5C),
                ),
              )
            : null,
        resizeToAvoidBottomInset: false,
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
                    //
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF2C3639),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 24.0,
                            color: Color(0xFFA27B5C),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: deleteNota,
                          style: ButtonStyle(
                            //todo: CHANGE THE COLOR
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 160, 146, 146),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.delete_forever,
                            size: 24.0,
                            color: Color(0xFFA27B5C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
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
                        initialValue: widget.data!['title'],
                        // ENABLE THE DEIT WHEN PRESSING TH EEDIT ICON
                        enabled: edit,
                        onChanged: (val) {
                          title = val;
                        },
                        validator: (val) {
                          if (val == null) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        child: Text(
                          widget.time!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFFDCD7C9),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Note Description",
                          hintStyle: TextStyle(
                            color: Color(0xFFDCD7C9),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFFDCD7C9),
                        ),
                        initialValue: widget.data!['description'],
                        enabled: edit,
                        onChanged: (val) {
                          des = val;
                        },
                        maxLines: 20,
                        validator: (val) {
                          if (val == null) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
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

  // delete nota from firesotre
  void deleteNota() async {
    await widget.ref!.delete();
    Navigator.pop(context);
  }

  // save the new details into firestore
  void save() async {
    if (key.currentState!.validate()) {
      await widget.ref!.update(
        {'title': title, 'description': des},
      );
    }
    Navigator.pop(context);
  }
}
