import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'VerifyOTP.dart';

class ProfileSelection extends StatefulWidget {
  const ProfileSelection({Key? key}) : super(key: key);

  @override
  _ProfileSelectionState createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liveasy'.tr),
    ),
    body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please select your profile".tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          ListTile(
            title: const Text('Shipper'),
            leading: Radio(
              value: 1,
              groupValue: 1,
              onChanged: (value) {
                setState(() {

                });
              },
            ),
          ),
          ListTile(
            title: const Text('Transporter'),
            leading: Radio(
              value: 2,
              groupValue: 2,
              onChanged: (value) {
                setState(() {

                });
              },
            ),
          ),
        ElevatedButton(
            onPressed: (){

            }, child: Text('CONTINUE'.tr, style: TextStyle(fontWeight: FontWeight.bold)),)
        ]
      )
    )
    );
  }
}
