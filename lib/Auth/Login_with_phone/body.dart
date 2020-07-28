import 'package:News/Auth/Components/text_field_container.dart';
import 'package:News/Auth/Home/home_screen.dart';
import 'package:News/Auth/Login/login_screen.dart';
import 'package:News/Auth/Signup/or_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:News/Auth/Login_with_phone/background.dart';
import 'package:News/Auth/Signup/signup_screen.dart';
import 'package:News/Auth/Components/already_have_an_acc.dart';
import 'package:News/Auth/Components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:News/Auth/contants.dart';


class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final phoneController1 = TextEditingController();
  final codeController = TextEditingController();

  // ignore: missing_return
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),

        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          user: user,
                        )));
          }else{
            print('error');
          }
        }, // when verification is done automatically

        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title:
                    Text('Give the One Time Password sent on your Phone No.'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: codeController,
                    ),
                    RoundedButton(
                      text: "Done",
                      press: () async {
                        final code = codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);
                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        user: user,
                                      )));
                        }else{
                          print('Error');
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        codeAutoRetrievalTimeout: null);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN with PHONE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            TextFieldContainer(
              child: TextField(
                controller: phoneController1,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                  ),
                  hintText: "Your Phone No.",
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                 final phone= phoneController1.text.trim();
                 
                 loginUser(phone,context);
                //
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: kPrimaryLightColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.email),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
