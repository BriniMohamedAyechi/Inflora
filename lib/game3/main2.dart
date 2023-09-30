import 'package:authentification/game3/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main2() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: const ProviderScope(child: MindGame())));
}

class MindGame extends StatelessWidget {
  const MindGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const MySplashScreen(),
    );
  }
}
