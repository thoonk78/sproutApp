import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprout/HomePage.dart';
import 'package:sprout/signUpPage.dart';
import 'package:sprout/sprout_user.dart';
import 'package:sprout/user_data_model.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SproutUser user = SproutUser();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            SignupPage(title: 'Signup Page')));
              },
              child: Text('Sign Up')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Future<void> populateUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    await (users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => user.name = value.get('name')));

    await (users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => user.age = value.get('age')));

    await (users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => user.weight = value.get('weight') as double));

    await (users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => user.goalWeight = value.get('goalWeight')));

    await (users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => user.heightInFT = value.get('heightFt')));

    await (users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => user.heightInIN = value.get('heightIn')));

    user.notifyListeners();
    users.doc(FirebaseAuth.instance.currentUser?.uid).get().then(
        (value) => debugPrint('name from database: ' + value.get('name')));

    debugPrint('name from object: ' + user.name);
  }

  void userSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      setState(() {
        populateUser();
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(user: user, title: 'Home Page')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: AssetImage('img/flat-abstract-nature.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 510,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    userInput(
                        emailController, 'Email', TextInputType.emailAddress),
                    userInput(passwordController, 'Password',
                        TextInputType.visiblePassword),
                    Container(
                      height: 55,
                      // for an exact replicate, remove the padding.
                      // pour une réplique exact, enlever le padding.
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: userSignIn,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text('Forgot password ?'),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: [
                          Text(
                            'Dont have an account?',
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [login(Icons.add)],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 0, color: Colors.white),
                    /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                    TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ],
                ),
                  */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
