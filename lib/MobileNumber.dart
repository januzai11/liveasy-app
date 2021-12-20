import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:phone_login/HomePage.dart';

import 'VerifyOTP.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  _MobileNumberState createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {

  String codeDigits = "+91";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              
              Padding(padding: const EdgeInsets.only(left:28, right:28),
                      child: Image.asset('images/login.jpg')),

              Container(
                child: Text('Please Enter your mobile number'.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ),

              Container(
                  child: Text('You will receive a 6 digit code to enter next '.tr, style: TextStyle( fontSize: 10))
              ),
              SizedBox(height: 50,),

              SizedBox(width: 400, height: 60,
              child: CountryCodePicker(onChanged: (country){
                setState((){
                  codeDigits = country.dialCode!;
                  });
                  },

                  initialSelection: "IN",
                  ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child:  TextField(
                  decoration: InputDecoration(hintText: 'Phone Number'.tr,
                  prefix: Padding(padding: EdgeInsets.all(4),
                    child: Text(codeDigits),

                    
                  ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number ,
                  controller: _controller,
                ),
              ),

              Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) => VerifyOTP(

                      phone: _controller.text,
                      codeDigits: codeDigits,
                    )));
                  }, child: Text('CONTINUE'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ),

              Container(margin: EdgeInsets.all(15),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                }, child: Text('BACK'.tr)),
              )



            ],
          )
        ),
      )

    );
  }
}
