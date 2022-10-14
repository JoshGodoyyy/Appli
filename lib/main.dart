import 'package:appli/customs/themes/theme_constants.dart';
import 'package:appli/pages/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
