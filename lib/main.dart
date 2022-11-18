import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/sign_in.dart';
import 'package:sprout/sprout_user.dart';
import 'package:sprout/user_data_model.dart';
import 'package:sprout/welcomePage.dart';

import 'FoodPage.dart';
import 'HomePage.dart';
import 'ProgressPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return SproutUser();
      },
      child: MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      initialRoute: '/-1',
      routes: <String, WidgetBuilder>{
        '/-1': (BuildContext context) => WelcomeScreen(),
        '/0': (BuildContext context) =>
            FoodsPage(title: 'Flutter Demo Home Page'),
        '/1': (BuildContext context) =>
            Consumer<SproutUser>(builder: (context, userDataModel, child) {
              return MyHomePage(title: 'Home page', user: userDataModel);
            }),
        '/2': (BuildContext context) => ProgressPage(title: 'Progress Page')
      },
    );
  }
}
