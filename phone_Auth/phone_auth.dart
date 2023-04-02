import 'package:firebase/phone_Auth/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class phone extends StatefulWidget {
  const phone({Key? key}) : super(key: key);

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
  String phoneNo="" , smssent="", verificationId=
  "";
  var phonecontroller=TextEditingController();
bool loading=false;
var auth=FirebaseAuth.instance;


final PhoneVerificationFailed verifyfail=(FirebaseAuthException exception){
 print(exception);
};

  Future verifyphone()async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve=(e){
      print(e);
    };


    await auth.verifyPhoneNumber(
  phoneNumber: phonecontroller.text,
      verificationCompleted: (_){

      },
      verificationFailed: verifyfail,
      codeSent: (String verificationid,int?token){
Navigator.push(context, MaterialPageRoute(builder: (context)=>verifycode(verificationid: verificationId,)));
      },
      codeAutoRetrievalTimeout:autoRetrieve,
);

  }
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phonecontroller,
              decoration: InputDecoration(

                  label: Text("Phonenumber"),
                
                hintText: "+92 3424627671"
              ),

            ),
            ElevatedButton(

             child:_isLoading ? CircularProgressIndicator() : Text("Send sms"),
    onPressed: verifyphone)
             ],
        ),
      ),
    );
  }
}
