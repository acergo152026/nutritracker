import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/app_db.dart';
import '../database/dao.dart';
import '../utils/format.dart';
import '../widgets/intake_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hoy"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: db.watchToday(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final ingestas = snapshot.data!;
          final totales = calcularTotales(ingestas);

          return Column(
            children: [
              _buildTotals(totales),
              Expanded(
                child: ListView.builder(
                  itemCount: ingestas.length,
                  itemBuilder: (_, i) => IntakeItem(ingesta: ingestas[i]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotals(Map<String, double> t) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Totales del día",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Calorías: ${t['calorias']!.toStringAsFixed(1)}"),
          Text("Proteínas: ${t['proteinas']!.toStringAsFixed(1)} g"),
          Text("Hidratos: ${t['hidratos']!.toStringAsFixed(1)} g"),
          Text("Grasas: ${t['grasas']!.toStringAsFixed(1)} g"),
        ],
      ),
    );
  }
}
