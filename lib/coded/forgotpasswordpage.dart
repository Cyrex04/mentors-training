// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgotpasswordpage extends StatefulWidget {
  const Forgotpasswordpage({Key? key}) : super(key: key);

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  final email = TextEditingController();
  Future<void> passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Reset password link sent, check your email"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter your email and we will send you a password reset link",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(style: BorderStyle.none),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  labelText: 'E-mail',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 6.0,
                    ), // Adjust the left and right padding values as per your requirement
                    child: Icon(Icons.email_outlined),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          MaterialButton(
            onPressed: passwordreset,
            color: Colors.black,
            child: const Text(
              "Reset password",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
