import 'package:expense_tracker/Expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.grey,
            textTheme: ThemeData().textTheme.copyWith(
        titleLarge: const TextStyle(
          fontSize: 17,
          color: Colors.purpleAccent
        )
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple
          )
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(190, 190, 100, 100))
      ),
      home: const Center(
        child: Expenses(),
      ),
    );
  }


}