import 'package:flutter/material.dart';
import 'package:we_helper_1/core/fixer/shiftRightFixed.dart';
import 'package:we_helper_1/core/window.dart';
import 'package:we_helper_1/pages/Home.dart';

void main() async {
  PCWindow.initWindow();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShiftRightFixer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color.fromRGBO(0, 17, 38, 1),
          scaffoldBackgroundColor: Color.fromRGBO(0, 36, 81, 1),
          accentColor: Colors.white,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              labelStyle: TextStyle(color: Color.fromRGBO(227, 157, 109, 1))),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                // bodyColor: Color.fromRGBO(237, 201, 133, 1),
                fontSizeDelta: 3,
                displayColor: Colors.white,
              ),
        ),
        home: HomePage(),
      ),
    );
  }
}
