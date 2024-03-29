import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_application_1/model/user_model.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupScreenState();
}

class _signupScreenState extends State<signup> {
  var nameController = TextEditingController();
  var mobilenocontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 148, 145, 126),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Username",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4))),
                style: const TextStyle(fontSize: 20),
                maxLines: 1,
                maxLength: 20,
                // focusNode: nameFocusnode,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Enter Username";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text("Mobile No.",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: mobilenocontroller,
                decoration: const InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4))),
                style: const TextStyle(fontSize: 20),
                maxLines: 1,
                maxLength: 20,
                // focusNode: nameFocusnode,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Enter Mobile_no.";
                  } else if ((value?.length ?? 0) < 10) {
                    return "Enter valid Mobile_no.";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text("E-Mail",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4))),
                style: const TextStyle(fontSize: 20),
                maxLines: 1,
                maxLength: 20,
                // focusNode: nameFocusnode,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Enter E-Mail";
                  } else if ((value?.length ?? 0) < 10) {
                    return "Enter valid E-Mail";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text("Password",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 4))),
                style: const TextStyle(fontSize: 20),
                maxLines: 1,
                maxLength: 20,
                // focusNode: nameFocusnode,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Enter Password";
                  } else if ((value?.length ?? 0) < 10) {
                    return "Enter valid Password";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            firebaseAuth
                                .createUserWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordController.text.toString())
                                .then((value) {
                              var userModel = UserModel(
                                  username: nameController.text.toString(),
                                  mobileNumber:
                                      mobilenocontroller.text.toString(),
                                  email: emailcontroller.text.toString(),
                                  uid: (firebaseAuth.currentUser?.uid ?? ""));
                              firebaseFirestore
                                  .collection("DetailsOfUser")
                                  .doc(firebaseAuth.currentUser?.uid ?? "")
                                  .set(userModel.toJson())
                                  //.add(userModel.toJson())
                                  .then((value) => Navigator.of(context).pop())
                                  .onError((error, stackTrace) =>
                                      Fluttertoast.showToast(
                                          msg: error.toString()));
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(msg: error.toString());
                            });
                          }
                        },
                        child: Text("Signup")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
