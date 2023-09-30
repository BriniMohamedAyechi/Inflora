import 'package:confetti/confetti.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'forgotPassword.dart';
import 'main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickSignup;


  const LoginWidget({Key? key, required this.onClickSignup}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool isPlaying = false;
  final controller = ConfettiController();
  int counter = 0 ;

  @override
  void initState(){
    super.initState();
    controller.addListener(() { });
    setState(() {
      isPlaying=controller.state==ConfettiControllerState.playing;
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(controller.state==ConfettiControllerState.playing){
          controller.stop();
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
                child: Image.asset(
              'images/lo9o2.png',
              height: 200,
              width: 200,
            )),
            SizedBox(
              height: 50,
            ),
            Text("Se Connecter",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.lightGreen),),
            SizedBox(height: 50,),
            TextFormField(
              controller: emailcontroller,
              cursorColor: Colors.black,
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
                      ? 'Entrez une adresse email vailde'
                      : null,
            ),
            SizedBox(
              height: 20,
            ),
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
                  borderRadius: new BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Entrez 6 charactéres au minimum'
                  : null,
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onLongPress: (){
                if(isPlaying){
                  controller.stop();
                }
                else{
                  controller.play();
                }
              },
              child: MaterialButton(
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0))),
                  minWidth: 170,
                  elevation: 5.0,
                  height: 40,
                  child: Text("Se connecter",style: TextStyle(fontSize: 24,color: Colors.white),),
                  onPressed: signIn
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Text(
                'Mot de passe oublié ',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                ),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage())),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    text: 'Pas de compte ?',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickSignup,
                      text: "  S'inscrire",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary))
                ])),
            ConfettiWidget(confettiController:
            controller,shouldLoop: true,
              blastDirectionality:
            BlastDirectionality.explosive,
            emissionFrequency: 0.20,
            gravity: 0.2,
            maxBlastForce: 2,
            minBlastForce: 1,)
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Email ou mot de passe incorrect',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15,
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
