import 'package:flutter/material.dart';
import 'package:flutter_trial/coded/studentlistpage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
