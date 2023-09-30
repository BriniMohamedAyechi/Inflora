import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey=GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
@override
  void dispose(){
    emailcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your email to send an email verification',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            TextFormField(
              controller: emailcontroller,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email'
                  : null,
            ),
            SizedBox(height: 20,),

            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),),
                icon: Icon(Icons.mail,size: 32,),
                label: Text('Reset Password',style: TextStyle(fontSize: 24),),
                onPressed: resetPassword,
            ),
          ],
        ),
      ),

    );
  }
  Future resetPassword() async{
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>Center(child: CircularProgressIndicator(),));
  try{
  await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailcontroller.text.trim());
  Fluttertoast.showToast(msg: 'An email has been sent to you check it out',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.blueAccent,
    textColor: Colors.white,
    fontSize: 15,);
  navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
  on FirebaseAuthException catch (e){
    Fluttertoast.showToast(msg: '${e.message}',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 15,);
    Navigator.of(context).pop();
  }

}}
