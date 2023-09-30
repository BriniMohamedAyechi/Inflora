
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raised_buttons/raised_buttons.dart';

import 'main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;


  const SignUpWidget({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Center(
                child: Image.asset('images/lo9o2.png',
                  height: 200,
                  width: 200,)
            ),
            SizedBox(height: 30,),
            Text("S'inscrire",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.lightGreen),),

            SizedBox(height: 50,),

            TextFormField(
              controller: emailcontroller,
              cursorColor: Colors.green,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.lightGreen)),
                hintText: "Email",
                icon: Icon(Icons.account_box, size: 20, color: Colors.lightGreen),
                filled: true,
                fillColor: Colors.white,
                enabled: true,
                contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.lightGreen),
                  borderRadius: new BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                ? 'Entrez une adresse email valide'
                  : null,
            ),
            SizedBox(height: 20,),
            SizedBox(height: 4,),
            TextFormField(
              obscureText: true,
              controller: passwordcontroller,
              cursorColor: Colors.green,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.lightGreen)),
                hintText: "Mot de passe",
                icon: Icon(Icons.lock, size: 20, color: Colors.lightGreen),
                filled: true,
                fillColor: Colors.white,
                enabled: true,
                contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.lightGreen),
                  borderRadius: new BorderRadius.circular(50),
                ),

              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator:(value)=> value !=null && value.length<6
                  ? 'Entrez 6 charactéres au minimum'
                  :null,

            ),
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true,
              controller: confirmcontroller,
              cursorColor: Colors.green,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.lightGreen)),
                hintText: "Confirmer mot de passe",
                icon: Icon(Icons.lock, size: 20, color: Colors.lightGreen),
                filled: true,
                fillColor: Colors.white,
                enabled: true,
                contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.lightGreen),
                  borderRadius: new BorderRadius.circular(50),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator:(value){
                if (confirmcontroller.text !=
                    passwordcontroller.text) {
                  return "Mot de pass non identique";
                } else {
                  return null;
                }
              },

            ),
            SizedBox(height: 60,),

              MaterialButton(
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(20.0))),
                  minWidth: 150,
                  elevation: 5.0,
                  height: 40,
                child: Text("S'inscrire",style: TextStyle(fontSize: 24,color: Colors.white),),
                  onPressed: signUp
              ),

            SizedBox(height: 30,),
            RichText(text: TextSpan(
                style: TextStyle(color: Colors.grey,fontWeight:FontWeight.bold,fontSize: 15),
                text: 'Vous avez déja un compte ?',
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap=widget.onClickedSignIn,
                      text: ' Se connectez',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary
                      )
                  )
                ]
            ))
          ],
        ),
      ),
    );
  }
  Future signUp() async{
    final isValid= formkey.currentState!.validate();
    if(!isValid) return;
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>Center(child: CircularProgressIndicator(),));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    }
    on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: '${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
            textColor: Colors.white,
              fontSize: 15,);
    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}
