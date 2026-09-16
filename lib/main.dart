import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(const HaudexApp());

class HaudexApp extends StatelessWidget {
  const HaudexApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HAUDEX Reviewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const HomeScreen(),
    );
  }
}
