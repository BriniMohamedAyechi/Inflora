import 'package:authentification/login.dart';
import 'package:authentification/signUp.dart';
import 'package:flutter/cupertino.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginWidget(
            onClickSignup: toggle,
          )
        : SignUpWidget(onClickedSignIn: toggle);
  }

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
