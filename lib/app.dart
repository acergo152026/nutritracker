import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_food_page.dart';
import 'pages/history_page.dart';

class NutriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriTracker',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/add': (_) => AddFoodPage(),
        '/history': (_) => HistoryPage(),
      },
    );
  }
}
