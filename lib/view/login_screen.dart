import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_cake_land/view/user_details.dart';

import 'home_screen.dart';

enum MobileVerificationState{
  SHOW_MOBILE_NO_STATE,
  SHOW_OTP_STATE
}

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_NO_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = "";
  bool showLoading = false;

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async{

    setState(() {
      showLoading = true;
    });
    try{
      final UserCredential authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if(authCredential.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserDetails()));
      }
    }on FirebaseAuthException catch(e){
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(e.message!)));

    }

  }

  getMobileNoWidget(context){
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: "Enter Phone No",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(onPressed: () async{

          setState(() {
            showLoading = true;
          });
          await _auth.verifyPhoneNumber(phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential)async{
                setState(() {
                  showLoading = false;
                });
              },
              verificationFailed: (verificationFailed)async{
                setState(() {
                  showLoading = false;
                });

                _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text( verificationFailed.message!)));

              },
              codeSent: (verificationId, resendingToken)async{
            showLoading = false;
                currentState = MobileVerificationState.SHOW_OTP_STATE;
                this.verificationId = verificationId;
              },
              codeAutoRetrievalTimeout: (verificationId) async{

          },
          );
        }, child: Text("SEND"))
      ],
    );

  }

  getOtpWidget(context){
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(onPressed: () async{
          final PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);
          signInWithPhoneAuthCredential(phoneAuthCredential);
        }, child: Text("VERIFY"))
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: showLoading?Center(child: CircularProgressIndicator(),): currentState == MobileVerificationState.SHOW_MOBILE_NO_STATE?
          getMobileNoWidget(context) :
          getOtpWidget(context)
    );
  }
}
