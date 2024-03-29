import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_application_1/model/user_model.dart';

class FutureDataScreen extends StatefulWidget {
  const FutureDataScreen({super.key});

  @override
  State<FutureDataScreen> createState() => _FutureDataScreenState();
}

class _FutureDataScreenState extends State<FutureDataScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _firebaseFirestore
              .collection("DetailsOfUser")
              .doc((_firebaseAuth.currentUser?.uid ?? ""))
              .get(),
          builder: (context, snapshot) {
            print("_firebaseAuth.currentUser?.uid ?? "
                " ${_firebaseAuth.currentUser?.uid ?? ""}");
            if (snapshot.hasData) {
              print("snapshot data ${snapshot.data}");
              if (snapshot.data?.data()?.isNotEmpty == true) {
                final data =
                    Map<String, dynamic>.from(snapshot.data?.data() as Map);
                print("data $data");
                userModel = UserModel.fromJson(data);

                return Column(
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
                );
              } else {
                return Center(
                  child: Text("Sorry"),
                );
              }
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
