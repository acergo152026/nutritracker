import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';

class NutritionAPI {
  final String apiKey;

  NutritionAPI(this.apiKey);

  Future<List<Food>> searchFoods(String query) async {
    final url = Uri.parse(
      'https://api.nal.usda.gov/fdc/v1/foods/search?query=$query&api_key=$apiKey'
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error al consultar la API");
    }

    final data = jsonDecode(response.body);
    final List foods = data["foods"] ?? [];

    return foods.map((item) {
      final nutrients = _extractNutrients(item["foodNutrients"]);
      return Food(
        name: item["description"] ?? "Desconocido",
        calories: nutrients["calories"] ?? 0,
        protein: nutrients["protein"] ?? 0,
        carbs: nutrients["carbs"] ?? 0,
        fat: nutrients["fat"] ?? 0,
      );
    }).toList();
  }

  Map<String, double> _extractNutrients(List nutrients) {
    double cal = 0, pro = 0, car = 0, fat = 0;

    for (var n in nutrients) {
      switch (n["nutrientName"]) {
        case "Energy":
          cal = n["value"]?.toDouble() ?? 0;
          break;
        case "Protein":
          pro = n["value"]?.toDouble() ?? 0;
          break;
        case "Carbohydrate, by difference":
          car = n["value"]?.toDouble() ?? 0;
          break;
        case "Total lipid (fat)":
          fat = n["value"]?.toDouble() ?? 0;
          break;
      }
    }

    return {
      "calories": cal,
      "protein": pro,
      "carbs": car,
      "fat": fat,
    };
  }
}
