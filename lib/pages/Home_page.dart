import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/components/wallposts.dart';
import '../coded/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final massage = TextEditingController();

  void sendMassage() {
    if (massage.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Userposts").add(
        {
          "user email": user.email!,
          "massage": massage.text,
          "timestamp": Timestamp.now()
        },
      );
    }
    setState(() {
      massage.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Your feed",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.14159),
          child: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await _googleSignIn.disconnect();
            },
            icon: const Icon(Icons.logout),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Userposts")
                  .orderBy("timestamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        user: post["user email"],
                        massage: post["massage"],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error${snapshot.hasError}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: massage,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter message here',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: sendMassage,
                  icon: const Icon(Icons.arrow_circle_up),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
