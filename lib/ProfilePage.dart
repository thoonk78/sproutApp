import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprout/welcomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProfilePage(title: 'Demo Profile Page'),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sprout'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: const BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => WelcomeScreen()));
              },
              icon: Icon(Icons.logout))
        ],
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text("Profile Page", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Change Profile Picture: ',
                    ))),
            const Padding(
                padding: EdgeInsets.all(1),
                child: IconButton(
                  icon: Icon(Icons.account_circle_outlined),
                  onPressed: null,
                  iconSize: 50,
                )),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Name: ',
                    ))),
            const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      hintText: 'Enter Full Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent))),
                )),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Weight: ',
                    ))),
            const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      hintText: 'Enter Weight In lbs',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent))),
                )),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Height: ',
                    ))),
            const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      hintText: 'Enter Height In cm',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent))),
                )),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Age: ',
                    ))),
            const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      hintText: 'Enter Age',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent))),
                )),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Goal Weight: ',
                    ))),
            const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      hintText: 'Enter Goal Weight in lbs',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.greenAccent))),
                )),
          ]),
    );
  }
}
