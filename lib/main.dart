import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'database/app_db.dart';
import 'services/nutrition_api.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AppDatabase()),
        Provider(create: (_) => NutritionAPI("YOUR_API_KEY_HERE")),
      ],
      child: NutriApp(),
    ),
  );
}
