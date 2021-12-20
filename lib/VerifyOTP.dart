import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'ProfileSelection.dart';

import 'MobileNumber.dart';

class VerifyOTP extends StatefulWidget {
  final String phone;
  final String codeDigits;

  VerifyOTP({required this.phone, required this.codeDigits});

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTP = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();

  late String verificationCode;

  final BoxDecoration _pinOTPDecoration = BoxDecoration(

    color: Colors.blueGrey,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.blueAccent,
    )
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    verifyPhoneNumber();
  }

  verifyPhoneNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async{

        await FirebaseAuth.instance.signInWithCredential(credential).then((value){
          if(value.user != null){
            Navigator.of(context).push(MaterialPageRoute(builder: (c) => ProfileSelection()));

          }

        });
        },
      verificationFailed:  (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()),
            duration: Duration(seconds: 5),

          ),



        );

      },

      codeSent: (String vID, int? resentToken){
        setState(() {
          verificationCode = vID;

        });
      },

      codeAutoRetrievalTimeout: (String vID)
      {
        setState(() {
          verificationCode = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Liveasy'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: (){
                  verifyPhoneNumber();

                },
                child: Text(
                  "Verifying: ${widget.codeDigits}-${widget.phone}".tr,
                  style: TextStyle(fontSize: 20),

                ),
              ),

            ),

            Padding(
              padding: EdgeInsets.all(40),
              child: PinPut(fieldsCount: 6,
                textStyle: TextStyle(fontSize: 25),
                eachFieldHeight: 55,
                eachFieldWidth: 40,
                focusNode: _pinOTPFocus,
                controller: _pinOTP,
                submittedFieldDecoration: _pinOTPDecoration,
                selectedFieldDecoration: _pinOTPDecoration,
                followingFieldDecoration: _pinOTPDecoration,
                pinAnimationType: PinAnimationType.none,
                onSubmit: (pin) async{

                try{
                  await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationCode!,
                      smsCode: pin)).then((value){
                    if(value.user != null){
                      Navigator.of(context).push(MaterialPageRoute(builder: (c) => ProfileSelection()));

                    }
                  });
                }
                catch(e){
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("OTP Invalid".tr),
                        duration: Duration(seconds: 5),

                      ),

                  );

                }


                },

              )

            )
          ]
        )
      )
    );
  }
}

