import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprout/HomePage.dart';
import 'package:sprout/newProfilePage.dart';
import 'package:sprout/signUpPage.dart';
import 'package:sprout/sign_in.dart';
import 'package:sprout/sprout_user.dart';
import 'package:sprout/user_data_model.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup-screen';
  const SignupPage({super.key, required this.title});

  final String title;

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  late final SproutUser user;

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
                        builder: (context) => SignupPage(
                              title: 'Signup Page',
                            )));
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
          border: Border.all(color: Colors.white30),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 137, 137, 137),
                spreadRadius: 1,
                blurRadius: 2)
          ],
          color: Colors.white,
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
                fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Future<void> createUser() async {
    try {
      if (passwordController.text == (passwordConfirmController.text)) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
        /*    
        users.add({
          'name': 'First Last',
          'uid': userCredential.user!.uid,
          'gender:': 'male',
          'age': '0',
          'height-ft': 0,
          'height-in': 0,
          'weight': 0,
          'goal-weight': 0,
        });
      */

        users.doc(userCredential.user!.uid).set({
          'name': 'First Last',
          'gender:': 'male',
          'age': '0',
          'height-ft': 0,
          'height-in': 0,
          'weight': 0,
          'goal-weight': 0,
        });

        user = SproutUser();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewProfilePage(
                      title: 'New Profile Page',
                      user: user,
                    )));
      } else {
        print('Passwords do not match');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pop(context);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: AssetImage('img/plant-pattern.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Sign up and keep track of your goals!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
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
                    userInput(passwordConfirmController, 'Confirm Password',
                        TextInputType.visiblePassword),
                    Container(
                      height: 55,
                      // for an exact replicate, remove the padding.
                      // pour une réplique exact, enlever le padding.
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: createUser,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have account? ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => LoginScreen(
                                                title: 'Signup Page',
                                              )));
                                }),
                        ]),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
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
