import 'package:firebase/phone_Auth/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class verifycode extends StatefulWidget {
final String verificationid;
  const verifycode({Key? key,required this.verificationid}) : super(key: key);

  @override
  State<verifycode> createState() => _verifycodeState();
}

class _verifycodeState extends State<verifycode> {
var otpcontroller=TextEditingController();
var auth=FirebaseAuth.instance;
bool _isLoading = false;

void _toggleLoading() {
  setState(() {
    _isLoading = !_isLoading;
  });}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: otpcontroller,

              decoration: InputDecoration(

                  label: Text("Otp"),

                  hintText: "6 digit otp",

              ),

            ),
            ElevatedButton(
              child: _isLoading ? CircularProgressIndicator(): Text("verify"),
                onPressed: ()async {

              final AuthCredential cradential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationid,
                  smsCode: otpcontroller.text.toString());
              try{
                await auth.signInWithCredential(cradential);
Navigator.push(context, MaterialPageRoute(builder: (context)=>homescreen()));
              }
              catch(e){
                print(e);
              }
              }

            )
          ],
        ),
      ),
    );
  }
}
