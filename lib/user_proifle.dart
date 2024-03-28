import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    firebaseFirestore
        .collection("DetailsOfUser")
        .where("uid", isEqualTo: (firebaseAuth.currentUser?.uid ?? ""))
        .get()
        .then((value) {
      print("value $value");
      var newValue = value.docChanges;
      print("newValue $newValue");
      // final data = Map<String, dynamic>.from(value as Map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Column(
        children: [Text("name"), Text("Email"), Text("Mobile Number")],
      ),
    );
  }
}
