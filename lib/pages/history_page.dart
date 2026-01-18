import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/app_db.dart';
import '../database/dao.dart';
import '../utils/format.dart';
import 'day_detail_page.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Historial")),
      body: StreamBuilder(
        stream: db.watchToday(), // simplificado
        builder: (context, snapshot) {
          return Center(
            child: Text(
              "Aquí puedes implementar un historial real más adelante.\nPor ahora, solo muestra el día actual.",
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
