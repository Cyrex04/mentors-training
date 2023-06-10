// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'studentlistpage.dart';
// class AddAStudent extends StatefulWidget {
//   const AddAStudent({Key? key}) : super(key: key);

//   @override
//   _AddAStudentState createState() => _AddAStudentState();
// }

// class _AddAStudentState extends State<AddAStudent> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
  
//   void saveStudentDetails() {
//     final String name = nameController.text;
//     // final String email = emailController.text;

//     // // Save student details to Firestore
//     // FirebaseFirestore.instance.collection('students').add({
//     //   'name': name,
//     //   'email': email,
//     // });

//     // Add the name to the students list
//     students.add(name);

//     // Navigate back to the previous page
//     Navigator.pop(context);
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add a Student'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: saveStudentDetails, // Call the saveStudentDetails function
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
