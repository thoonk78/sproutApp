import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:sprout/sprout_user.dart';
import 'package:sprout/user_data_model.dart';
import 'user_data_model.dart';
import 'FoodPage.dart';
import 'ProfilePage.dart';

class MyHomePage extends StatefulWidget {
  final SproutUser user;
  MyHomePage({required this.user, Key? key, required String title})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var selectedIndex = 1;

    var users = FirebaseFirestore.instance.collection('Users');

    /// Goes to the page that the user taps on the bottom navigation bar
    void _onItemTapped(int index) {
      selectedIndex = index;
      Navigator.of(context).pushReplacementNamed('/${index}');
    }

    ///Goes to profile page when user taps profile icon
    void goToProfile() {
      debugPrint(widget.user.name);
      widget.user.notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                    title: 'Profile Page',
                  )));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sprout'),
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: IconButton(
            // Adds a profile icon at the top of the app bar that the user can tap on to go to profile
            onPressed:
                goToProfile, // allows user to tap on the icon to go to their profile page
            icon: Icon(Icons.account_circle_outlined),
            iconSize: 30,
          ),
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Text(
                "Name: ${widget.user.name}  Age: ${widget.user.age}  Height:${widget.user.heightInFT}'${widget.user.heightInIN}\"", // Shows name, age, and height of user
                style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(children: <Widget>[
          SizedBox(
              height: 500,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(children: [
                    const Padding(
                      // Shows a bar representing what the user has consumed for each category
                      padding: EdgeInsets.all(3),
                      child: Text('Calories'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FAProgressBar(
                        currentValue: widget.user.curCal as double,
                        displayText: '',
                        backgroundColor: Colors.red,
                        animatedDuration: const Duration(milliseconds: 300),
                        maxValue: widget.user.calorieLimit,
                        progressColor: const Color.fromARGB(255, 247, 136, 128),
                        size: 40,
                      ),
                    ),
                    const Padding(
                      // Shows a bar representing what the user has consumed for each category
                      padding: EdgeInsets.all(3),
                      child: Text('Sugar'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FAProgressBar(
                        currentValue: widget.user.curSugar as double,
                        displayText: '',
                        backgroundColor: Colors.pink,
                        animatedDuration: const Duration(milliseconds: 300),
                        maxValue: widget.user.sugarLimit,
                        progressColor: Color.fromARGB(255, 236, 128, 196),
                        size: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(3),
                      child: Text('Fat'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FAProgressBar(
                        currentValue: widget.user.curFat as double,
                        displayText: '',
                        backgroundColor: Colors.orange,
                        animatedDuration: const Duration(milliseconds: 300),
                        maxValue: widget.user.fatLimit,
                        progressColor: const Color.fromARGB(255, 255, 201, 114),
                        size: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(3),
                      child: Text('Sodium'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FAProgressBar(
                        currentValue: widget.user.curSodium as double,
                        displayText: '',
                        backgroundColor: Colors.purple,
                        animatedDuration: const Duration(milliseconds: 300),
                        maxValue: widget.user.sodiumLimit,
                        progressColor: const Color.fromARGB(255, 238, 146, 254),
                        size: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(3),
                      child: Text('Water'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FAProgressBar(
                        currentValue: widget.user.curWater as double,
                        displayText: '',
                        backgroundColor: Colors.blue,
                        animatedDuration: const Duration(milliseconds: 300),
                        maxValue: widget.user.waterLimit,
                        progressColor: const Color.fromARGB(255, 130, 199, 255),
                        size: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'Add Food',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.green),
                          )),
                    )
                  ]))),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          //Displays a navigation bar at the bottom of the screen
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ));
  }
}
