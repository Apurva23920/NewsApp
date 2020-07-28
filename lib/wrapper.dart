import 'package:News/Auth/Welcome/welcome_screen.dart';
import 'package:News/screens/feed.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:News/Auth/models/user.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
  
   if(user==null){
    return WelcomeScreen();
    }
    else{
      return Feed();
    }
  }
}