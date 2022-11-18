import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';

import 'ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProgressPage(title: 'Demo Progress Page'),
    );
  }
}

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key, required this.title});

  final String title;

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  var _selectedIndex = 2;

  /// Goes to the page that the user tapped on the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pushReplacementNamed('/${index}');
    });
  }

  /// Lists the bars that will represent the amount of things that a user has consumed
  final List<Feature> features = [
    Feature(
      title: "Water",
      color: Colors.blue,
      data: [0.2, 0.8, 0.4, 0.7, 0.6],
    ),
    Feature(
      title: "Calories",
      color: Colors.red,
      data: [1, 0.8, 0.6, 0.7, 0.3],
    ),
    Feature(
      title: "Sodium",
      color: Colors.purple,
      data: [0.5, 0.4, 0.85, 0.4, 0.7],
    ),
    Feature(
      title: "Fat",
      color: Colors.orange,
      data: [0.6, 0.2, 0, 0.1, 1],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sprout'),
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ProfilePage(
                          title:
                              'Profile Page'))); // goes to profile page when user presses profile icon
            },
            iconSize: 30,
          ),
          bottom: const PreferredSize(
            preferredSize: Size.zero,
            child: Text("Profile Page", style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Progress ",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            LineGraph(
              // Displays a line graph showing the user's progress over a period of time
              features: features,
              size: const Size(320, 400),
              labelX: const ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
              labelY: const ['20%', '40%', '60%', '80%', '100%'],
              showDescription: true,
              graphColor: Colors.black,
              graphOpacity: 0.2,
              verticalFeatureDirection: true,
              descriptionHeight: 130,
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ));
  }
}
