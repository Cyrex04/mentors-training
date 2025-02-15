import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_trial/coded/main_page.dart';
import 'package:flutter_trial/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'coded/fancysignin.dart';
import 'coded/forgotpasswordpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainPage());
  }
}

class LoginPage extends StatefulWidget {
  final VoidCallback register;

  const LoginPage({Key? key, required this.register}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFADB6C4),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Color(0xFF294C60)),
            ),
          ),
        );
      },
    );
  }

  Future<void> signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorDialog(e.code);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFD3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Icon(
                  Icons.school,
                  size: 150,
                  color: Color(0xFF001B2E),
                ),
                SizedBox(height: 48),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFADB6C4).withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xFF294C60),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFADB6C4).withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          color: Color(0xFF294C60),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const Forgotpasswordpage();
                      }),
                    );
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 16, color: Color(0xFF001B2E)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF001B2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Color(0xFFFFEFD3), fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Or continue with",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF294C60),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageBox(
                      imagepath: "assets/images/apple.png",
                      onTap: () {
                        GoogleSignInHelper().signInWithGoogle();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    ImageBox(
                      imagepath: "assets/images/google.png",
                      onTap: () {
                        GoogleSignInHelper().signInWithGoogle();
                        bool googlesignedin = true;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not registered yet?",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    GestureDetector(
                      onTap: widget.register,
                      child: Text(
                        " Register now!",
                        style: TextStyle(color: Color(0xFF001B2E)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final String imagepath;
  final void Function()? onTap;

  const ImageBox({
    Key? key,
    required this.imagepath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFADB6C4).withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagepath,
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool startlogin = true;
  void togglescreens() {
    setState(() {
      startlogin = !startlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (startlogin) {
      return LoginPage(register: togglescreens);
    } else {
      return RegisterPage(showlogin: togglescreens);
    }
  }
}

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

class StudentDetailsPage extends StatefulWidget {
  final String studentName;
  final String email;

  const StudentDetailsPage({
    Key? key,
    required this.studentName,
    required this.email,
  }) : super(key: key);

  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final grade = TextEditingController();
  String selectedgrade = "";
  final writtenemailcontroler = TextEditingController();
  String Writtenemail = "";
  List<String> impressions = [
    '😃',
    '😊',
    '😍',
    '🤩',
    '😎',
    '😕',
    '😔',
    '🤔',
    '😡',
    '🥱',
  ];
  String selectedImpression = '';
  List<String> food = [
    'Burger',
    'Hot dog',
    'Machboos',
    'Samboosa',
    'Koshary',
    'Mandy',
    'Beryani',
    'Fish',
    'Shrimp',
    'Chicken',
    'Pasta',
    'Steak',
    'Pizza',
  ];
  String selectedfood = '';
  List<String> appointement = [
    '8-9',
    '9-10',
    '10-11',
    '11-12',
    '13-14',
    '15-16',
    '17-18',
  ];
  String selectedapointement = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFD3),
      appBar: AppBar(
        backgroundColor: Color(0xFF001B2E),
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Name: ${widget.studentName}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              buildActionCard(
                icon: Icons.email,
                color: Colors.grey,
                title: 'Send Email to ${widget.studentName}',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(
                            '${widget.studentName} doesnt want to get an email right now'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              buildActionCard(
                color: Colors.grey,
                icon: Icons.rate_review,
                title: 'Grading Final Project for ${widget.studentName}',
                subtitle: selectedgrade.isNotEmpty
                    ? '${widget.studentName} grade is : $selectedgrade'
                    : 'Tap to enter grade',
                onTap: () {
                  showgradingDialog();
                },
              ),
              const SizedBox(height: 10),
              buildActionCard(
                color: Colors.grey,
                icon: Icons.food_bank,
                title: 'Favorite Snack of ${widget.studentName}',
                subtitle: selectedfood.isNotEmpty
                    ? 'Selected: $selectedfood'
                    : 'Tap to choose',
                onTap: () {
                  showfoodDialog();
                },
              ),
              const SizedBox(height: 10),
              buildActionCard(
                color: Colors.grey,
                icon: Icons.add_reaction_sharp,
                title: 'Choose Impression',
                subtitle: selectedImpression.isNotEmpty
                    ? 'Selected: $selectedImpression'
                    : 'Tap to choose',
                onTap: () {
                  showImpressionDialog();
                },
              ),
              const SizedBox(height: 10),
              buildActionCard(
                color: Colors.grey,
                icon: Icons.calendar_today,
                title: 'Schedule Meeting with ${widget.studentName}',
                subtitle: selectedapointement.isNotEmpty
                    ? 'Apointement with ${widget.studentName} at $selectedapointement'
                    : 'Tap to choose an apointement',
                onTap: () {
                  showApointementDialog();
                },
              ),
              const SizedBox(height: 10),
              buildActionCard(
                  color: Colors.grey,
                  icon: Icons.report,
                  title: 'Report ${widget.studentName} for cheating',
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  bool isBanned = false;

  Widget buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    String subtitle = '',
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        tileColor: isBanned ? Colors.redAccent : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        onTap: () {
          setState(() {
            if (title == 'Report ${widget.studentName} for cheating') {
              isBanned = true;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Student Banned'),
                    content: const Text('This student has been banned.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              onTap();
            }
          });
        },
      ),
    );
  }

  void showImpressionDialog() {
    if (isBanned == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Student Banned'),
            content: const Text(
                'Student Banned, you can no longer interact with him'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Impression'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: impressions.length,
                itemBuilder: (context, index) {
                  final emoji = impressions[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImpression = emoji;
                      });
                      Navigator.pop(context);
                    },
                    child: emojie_tiles(user: emoji),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  void showApointementDialog() {
    if (isBanned == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Student Banned'),
            content: const Text(
                'Student Banned, you can no longer interact with him'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose a suitable time'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: appointement.length,
                itemBuilder: (context, index) {
                  final choosenapointement = appointement[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedapointement = choosenapointement;
                      });
                      Navigator.pop(context);
                    },
                    child: emojie_tiles(user: choosenapointement),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  void showgradingDialog() {
    if (isBanned == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Student Banned'),
            content: const Text(
                'Student Banned, you can no longer interact with him'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('insert a grade for ${widget.studentName}'),
            content: Container(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: grade,
                  decoration: InputDecoration(
                    labelText: 'Enter grade here',
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.add_box_rounded),
                      onTap: () {
                        setState(() {
                          selectedgrade = grade.text.toString();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void showfoodDialog() {
    if (isBanned == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Student Banned'),
            content: const Text(
                'Student Banned, you can no longer interact with him'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose food'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: food.length,
                itemBuilder: (context, index) {
                  final choosenfood = food[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedfood = choosenfood;
                      });
                      Navigator.pop(context);
                    },
                    child: emojie_tiles(user: choosenfood),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }
}

class emojie_tiles extends StatelessWidget {
  final String user;

  const emojie_tiles({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  final VoidCallback showlogin;

  const RegisterPage({Key? key, required this.showlogin}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final confirmedPassword = TextEditingController();
  bool isRegistering = false;

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFADB6C4),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  Future<void> signup() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (_password.text.trim() == confirmedPassword.text.trim()) {
      setState(() {
        isRegistering = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showErrorMessage(e.code);
      }

      setState(() {
        isRegistering = false;
      });
    } else {
      showErrorMessage("The passwords do not match");
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    confirmedPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFD3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Join Our Community',
                    style: GoogleFonts.bangers(
                      fontSize: 40,
                      color: Color(0xFF001B2E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: ' E-mail',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                          child: Icon(Icons.email_outlined, color: Colors.grey),
                        ),
                      ),
                    ),
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
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                          child:
                              Icon(Icons.password_outlined, color: Colors.grey),
                        ),
                      ),
                    ),
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
                      controller: confirmedPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confirm your password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                          child:
                              Icon(Icons.password_outlined, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 30, 70, 0),
                  child: Center(
                    child: GestureDetector(
                      onTap: signup,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFF001B2E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isRegistering
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFF001B2E),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF001B2E),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFF001B2E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageBox(
                        imagepath: "assets/images/google.png",
                        onTap: () {
                          GoogleSignInHelper().signInWithGoogle();
                          bool googleSignedIn = true;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF001B2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showlogin,
                        child: Text(
                          ' Login!',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
