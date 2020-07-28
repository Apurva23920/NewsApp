import 'package:News/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:News/Auth/Welcome/background.dart';
import 'package:News/Auth/Components/rounded_button.dart';
import 'package:News/Auth/contants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class Body extends StatefulWidget {

  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static const platform = const MethodChannel("razorpay_flutter");
  FlutterToast flutterToast;
  Razorpay razorpay;
  String iid;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //
    // This size provide us total height and width of our screen
    if (iid == 'undefined' || iid == null) {
      return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO NewzBuzz",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "Subscribe Now",
                press: openCheckout,
              ),
              RoundedButton(
                text: "30-Day free trial",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Feed();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO NewzBuzz",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "Go to Home",
                press: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Feed()));
                },
              ),
              
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    flutterToast = FlutterToast(context);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_QZbutHCBXN0Y15',
      'amount': '30000',
      'name': 'NewsBuzz',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  _showToast(String id) {
    Widget toast1 = Container(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
            backgroundBlendMode: BlendMode.darken,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 70),
                child: Text(
                  "PAYMENT SUCCESSFUL",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  "Rs.300",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: Text(
                  "TRANSACTION ID",
                  style: TextStyle(fontSize: 14, color: Colors.grey[750]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 6, left: 6, bottom: 20, top: 2),
                child: Text(
                  id,
                  style: TextStyle(fontSize: 14, color: Colors.grey[750]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 2, bottom: 20),
                    child: Text(
                      'need help?',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 20),
                    child: Text(
                      'click here',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 2, bottom: 20),
                    child: Text(
                      'for Support',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //circle

    flutterToast.showToast(
      child: toast1,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 4),
    );
  }

  _showToast2(String msg) {
    Widget toast2 = Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
          backgroundBlendMode: BlendMode.darken,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "PAYMENT FAILED",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                "Error:",
                style: TextStyle(fontSize: 14, color: Colors.grey[750]),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 6, left: 6, bottom: 20, top: 2),
              child: Text(
                msg,
                style: TextStyle(fontSize: 14, color: Colors.grey[750]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 2, bottom: 5),
                  child: Text(
                    'need help?',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 5),
                  child: Text(
                    'click here',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 2, bottom: 5),
                  child: Text(
                    'for Support',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    flutterToast.showToast(
        child: toast2,
        toastDuration: Duration(seconds: 4),
        gravity: ToastGravity.CENTER);
  }

  _showToast3(String wallet) {
    Widget toast3 = Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
          backgroundBlendMode: BlendMode.darken,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "PAYMENT SUCCESSFUL",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                "Rs.300",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                "External Wallet:",
                style: TextStyle(fontSize: 14, color: Colors.grey[750]),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 6, left: 6, bottom: 20, top: 2),
              child: Text(
                wallet,
                style: TextStyle(fontSize: 14, color: Colors.grey[750]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 2, bottom: 5),
                  child: Text(
                    'need help?',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 5),
                  child: Text(
                    'click here',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 2, bottom: 5),
                  child: Text(
                    'for Support',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    flutterToast.showToast(
        child: toast3,
        toastDuration: Duration(seconds: 4),
        gravity: ToastGravity.CENTER);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _showToast(response.paymentId);
    setState(() {
      iid = response.paymentId;
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _showToast2(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showToast3(response.walletName);
  }
}
