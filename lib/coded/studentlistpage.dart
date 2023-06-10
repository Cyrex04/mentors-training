import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_trial/coded/student_detailspage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  List<String> students = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Davis',
    'David Johnson',
    'Sarah Williams',
    'Daniel Lee',
    'Olivia Brown',
  ];

  List<String> filteredStudents = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  void filterStudents(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredStudents = students
            .where((student) =>
                student.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredStudents = students;
      });
    }
  }

  void navigateToStudentDetails(String studentName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsPage(
          studentName: studentName,
          email: "$studentName@gmail.com",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF294C60),
        title: const Text(
          "Students list",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await _googleSignIn.disconnect();
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterStudents,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                String username = filteredStudents[index];
                return GestureDetector(
                  child: ListTile(
                    title: StudentTiles(user: username),
                  ),
                  onTap: () => navigateToStudentDetails(username),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StudentTiles extends StatelessWidget {
  final String user;

  const StudentTiles({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFEFD3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_circle,
                size: 24,
                color: Color(0xFF001B2E),
              ),
              SizedBox(width: 8),
              Text(
                user,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF001B2E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
