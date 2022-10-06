import 'package:alyak/presentation/home_page/home_page.dart';
import 'package:alyak/util/dory_themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DoryThemes.lightTheme,
      home: const HomePage(),
      darkTheme: DoryThemes.darkTheme,
    );
  }
}
