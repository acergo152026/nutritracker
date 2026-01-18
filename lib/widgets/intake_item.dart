import 'package:flutter/material.dart';
import '../models/intake.dart';

class IntakeItem extends StatelessWidget {
  final Intake ingesta;

  IntakeItem({required this.ingesta});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ingesta.name),
      subtitle: Text("${ingesta.grams} g"),
      trailing: Text("${ingesta.calories.toStringAsFixed(0)} kcal"),
    );
  }
}
