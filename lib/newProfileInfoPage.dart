import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprout/HomePage.dart';
import 'package:sprout/signUpPage.dart';
import 'package:sprout/user_data_model.dart';
import 'package:sprout/sprout_user.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'newProfilePage.dart';

class NewProfileInfoPage extends StatefulWidget {
  //UserDataModel user = NewProfilePage().user;
  NewProfileInfoPage({Key? key, required String title, required user})
      : super(key: key);

  final SproutUser user = SproutUser();

  @override
  State<NewProfileInfoPage> createState() => _NewProfileInfoPageState();
}

class _NewProfileInfoPageState extends State<NewProfileInfoPage> {
  static const routeName = '/login-screen';

  final feetController = TextEditingController();
  final inchesController = TextEditingController();
  final weightController = TextEditingController();
  final goalWeightController = TextEditingController();

  //UserDataModel user = this.user;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /*
  Future<void> addUser() async {
    users.add({
      'name': widget.user.name,
      'id': FirebaseAuth.instance.currentUser?.uid
    });
  }
  */

  void populateUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => widget.user.name = value.get('name'));

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => widget.user.age = value.get('age'));

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => widget.user.weight = value.get('weight'));

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => widget.user.goalWeight = value.get('goalWeight'));

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => widget.user.heightInFT = value.get('heightFt'));

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => widget.user.heightInIN = value.get('heightIn'));
  }

  void setUserData() {
    /*
    widget.user.heightInFT = int.parse(feetController.text);
    widget.user.heightInIN = int.parse(inchesController.text);
    widget.user.weight = double.parse(weightController.text);
    widget.user.goalWeight = double.parse(goalWeightController.text);
    */
    var users = FirebaseFirestore.instance.collection('Users');

    users.doc(FirebaseAuth.instance.currentUser?.uid).set({
      'heightFt': int.parse(feetController.text),
      'heightIn': int.parse(inchesController.text),
      'weight': double.parse(weightController.text),
      'goalWeight': double.parse(goalWeightController.text)
    }, SetOptions(merge: true));
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: AssetImage('img/early-morning.jpg'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Nice to Meet you!', style: TextStyle(fontSize: 40)),
            Text('Tell us a little more about yourself',
                style: TextStyle(fontSize: 20)),
            Container(
              height: 475,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    Text(
                      'How tall are you?',
                      style: TextStyle(fontSize: 35),
                    ),
                    userInput(feetController, 'feet', TextInputType.number),
                    userInput(inchesController, 'inches', TextInputType.number),
                    userInput(weightController, 'What is your weight? (lbs)',
                        TextInputType.number),
                    userInput(
                        goalWeightController,
                        'What weight are you trying to achieve? (lbs)',
                        TextInputType.number),
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        debugPrint('Name: ' + widget.user.name);
                        debugPrint('Age: ' + widget.user.age.toString());
                        debugPrint('it worked');
                      },
                      child: Text(
                        'Test before textFields',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      // for an exact replicate, remove the padding.
                      // pour une réplique exact, enlever le padding.
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              setUserData();
                              populateUser();
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                          user: widget.user,
                                          title: 'Home Page')));
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
