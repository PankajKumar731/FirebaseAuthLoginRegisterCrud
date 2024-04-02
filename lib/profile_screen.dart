import 'package:flutter/material.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text("Profile"),
          actions: [
            ElevatedButton(onPressed: null, child: Text("Edit Profile"))
          ],
        ),
        body: Column(
          children: [
            // Icon(
            //   Icons.account_circle,
            //   size: 50,
            //   color: Colors.purple,
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "USER",
            //       style: TextStyle(
            //         fontSize: 20,
            //         color: Colors.purple,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TextField(
                  // focusNode: userfocusnode,
                  // controller: usercontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Colors.purple,
                      ),
                      hintText: "UserName",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.purple)),
                  onSubmitted: (value) {
                    // if (usercontroller.text.toString().isEmpty) {
                    //   Fluttertoast.showToast(msg: "Enter Username");
                    // } else {
                    //   passfocusnode.requestFocus();
                    // }
                    // ;
                  }),
            ),
          ],
        ));
  }
}
