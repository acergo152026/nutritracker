import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/app_db.dart';
import '../database/dao.dart';
import '../services/nutrition_api.dart';
import '../models/food.dart';

class AddFoodPage extends StatefulWidget {
  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final name = TextEditingController();
  final grams = TextEditingController();
  final cal = TextEditingController();
  final pro = TextEditingController();
  final car = TextEditingController();
  final fat = TextEditingController();

  final searchCtrl = TextEditingController();
  List<Food> resultados = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    final api = Provider.of<NutritionAPI>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Añadir alimento")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Buscar alimento (API USDA):"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(labelText: "Ej: apple"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    setState(() => loading = true);
                    resultados = await api.searchFoods(searchCtrl.text);
                    setState(() => loading = false);
                  },
                )
              ],
            ),

            if (loading) Center(child: CircularProgressIndicator()),

            if (resultados.isNotEmpty)
              ...resultados.map((food) => ListTile(
                    title: Text(food.name),
                    subtitle: Text(
                        "Cal: ${food.calories}  Prot: ${food.protein}  Carb: ${food.carbs}  Grasa: ${food.fat}"),
                    onTap: () {
                      name.text = food.name;
                      cal.text = food.calories.toString();
                      pro.text = food.protein.toString();
                      car.text = food.carbs.toString();
                      fat.text = food.fat.toString();
                    },
                  )),

            Divider(),
            Text("Añadir manualmente:"),

            _field(name, "Nombre"),
            _field(grams, "Cantidad (g)"),
            _field(cal, "Calorías / 100g"),
            _field(pro, "Proteínas / 100g"),
            _field(car, "Hidratos / 100g"),
            _field(fat, "Grasas / 100g"),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final g = double.parse(grams.text);
                final factor = g / 100;

                db.addIntake(
                  name: name.text,
                  grams: g,
                  calories: double.parse(cal.text) * factor,
                  protein: double.parse(pro.text) * factor,
                  carbs: double.parse(car.text) * factor,
                  fat: double.parse(fat.text) * factor,
                );

                Navigator.pop(context);
              },
              child: Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
