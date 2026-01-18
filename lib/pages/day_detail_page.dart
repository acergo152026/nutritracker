import 'package:flutter/material.dart';
import '../models/intake.dart';
import '../widgets/intake_item.dart';

class DayDetailPage extends StatelessWidget {
  final List<Intake> ingestas;

  DayDetailPage({required this.ingestas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle del día")),
      body: ListView.builder(
        itemCount: ingestas.length,
        itemBuilder: (_, i) => IntakeItem(ingesta: ingestas[i]),
      ),
    );
  }
}
