import 'package:News/Auth/Welcome/welcome_screen.dart';
import 'package:News/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:News/Auth/services/auth.dart';
import 'package:News/Auth/models/user.dart';
import 'package:News/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(
          color: Colors.white,
          debugShowCheckedModeBanner: false,

        home: Wrapper(),
      ),
    );
  }
}

 