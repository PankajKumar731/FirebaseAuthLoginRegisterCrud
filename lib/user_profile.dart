import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_application_1/model/user_model.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserModel userModel = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  // getData() {
  //   firebaseFirestore
  //       .collection("DetailsOfUser")
  //       .where("uid", isEqualTo: (firebaseAuth.currentUser?.uid ?? ""))
  //       .get()
  //       .then((value) {
  //     print("value $value");
  //     var newValue = value.docChanges;
  //     print("newValue $newValue");
  //     if (value.docs.isNotEmpty) {
  //       for (int i = 0; i < value.docs.length; i++) {
  //         print("value docs ${value.docs[i]}");
  //         final data = Map<String, dynamic>.from(value.docs[i].data() as Map);
  //         print("data $data");
  //         userModel = UserModel.fromJson(data);
  //         setState(() {});
  //       }
  //     }
  //     //
  //   });
  // }

  getData() {
    firebaseFirestore
        .collection("DetailsOfUser")
        .doc(firebaseAuth.currentUser?.uid ?? "")
        .get()
        .then((value) {
      print("value $value");
      final data = Map<String, dynamic>.from(value.data() as Map);
      print("data $data");
      userModel = UserModel.fromJson(data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Column(
        children: [
          Text(
            "name = ${userModel.username}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Email = ${userModel.email}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Mobile Number = ${userModel.mobileNumber}",
            style: TextStyle(fontSize: 40),
          )
        ],
      ),
    );
  }
}
