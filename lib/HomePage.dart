import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MobileNumber.dart';

class HomePage extends StatelessWidget {

  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Liveasy'.tr, textAlign: TextAlign.center,)),

        body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please select your language'.tr,style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text('You can change your language at any time'.tr,style: TextStyle(fontSize: 15),),

            ElevatedButton(onPressed: (){
              buildLanguageDialog(context);
            }, child: Text('Change Language'.tr)),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MobileNumber(),));
            }, child: Text('NEXT'.tr)),
          ],
        )
        )
    );
  }
}