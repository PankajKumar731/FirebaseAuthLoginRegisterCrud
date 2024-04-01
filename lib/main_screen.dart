import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_field_application_1/login.dart';
import 'package:form_field_application_1/notes_model.dart';
import 'package:form_field_application_1/permissions/pick_image.dart';
import 'package:form_field_application_1/user_profile.dart';

import 'future_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  var list = <NotesModel>[];
  @override
  void initState() {
    super.initState();
    getDatabaseValues();
  }

  getDatabaseValues() {
    firebaseDatabase.ref().get().then((value) {
      list.clear();
      value.children.forEach((msgSnapshot) {
        final data = Map<String, dynamic>.from(msgSnapshot.value as Map);
        NotesModel notesModel = NotesModel.fromJson(data);
        notesModel.id = msgSnapshot.key;
        list.add(notesModel);
        setState(() {});
      });
    }).onError((error, stackTrace) {
      print("error $error");
    });
  }

  void showAddDialog() {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Notes to add"),
            content: Form(
                key: formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(controller: titleController),
                  TextFormField(
                    controller: descriptionController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                NotesModel notesModel = NotesModel(
                                    title: titleController.text.toString(),
                                    description:
                                        descriptionController.text.toString());
                                firebaseDatabase
                                    .ref()
                                    .push()
                                    .set(notesModel.toJson())
                                    .then((value) {
                                  print("data entered");
                                  Navigator.of(context).pop();
                                  getDatabaseValues();
                                }).onError((error, stackTrace) {
                                  print("error $error");
                                });
                              }
                            },
                            child: Text("Add Notes"))
                      ],
                    ),
                  )
                ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to App"), actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PickImageScreen()));
            },
            child: Text("Profile")),
        ElevatedButton(
            onPressed: () {
              firebaseAuth.signOut().then((value) => Navigator.of(context)
                  .pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false));
            },
            child: Text("Logout"))
      ]),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  onLongPress: () {
                    firebaseDatabase.ref().child(list[index].id ?? "").remove();
                    getDatabaseValues();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        list[index].title ?? "",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(list[index].description ?? ""),
                    ],
                  ),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
