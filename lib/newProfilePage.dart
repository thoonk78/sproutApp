import 'dart:ui';
import 'package:sprout/sprout_user.dart';

import 'HomePage.dart';
import 'user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprout/signUpPage.dart';
import 'dart:developer';

import 'newProfileInfoPage.dart';

const List<String> genders = ['', 'male', 'female', 'other'];

class NewProfilePage extends StatefulWidget {
  final SproutUser user;
  NewProfilePage({Key? key, required String title, required this.user})
      : super(key: key);

  static const routeName = '/login-screen';

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  //UserDataModel user = UserDataModel();
  void setUserData() {
    widget.user.name = nameController.text;
    widget.user.age = int.parse(ageController.text);
    widget.user.gender = dropdownValue;

    var users = FirebaseFirestore.instance.collection('Users');

    users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'name': widget.user.name, 'age': widget.user.age});
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

  String dropdownValue = genders.first;

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
            Text('Hello There!', style: TextStyle(fontSize: 40)),
            Text('What is your...', style: TextStyle(fontSize: 20)),
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
                    userInput(nameController, 'Name', TextInputType.name),
                    userInput(ageController, 'Age', TextInputType.number),
                    DropdownButton<String>(
                      value: dropdownValue,
                      hint: Text(dropdownValue),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 45,
                        color: Colors.blueGrey.shade200.withOpacity(0.7),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        dropdownValue = value!;
                      },
                      items:
                          genders.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        debugPrint('Name: ' + widget.user.name);
                        debugPrint('Age: ' + widget.user.age.toString());
                        debugPrint('it worked');
                        setUserData();
                      },
                      child: Text(
                        'Test',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewProfileInfoPage(
                                            title: 'New Profile Info Page',
                                            user: widget.user,
                                          )));
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
                          ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              setUserData();
                              debugPrint('Name: ' + widget.user.name);
                              debugPrint('Age: ' + widget.user.age.toString());
                              debugPrint('it worked');
                            },
                            child: Text(
                              'Test',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text('Forgot password ?'),
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
