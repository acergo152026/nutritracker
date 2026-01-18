import '../models/intake.dart';

Map<String, double> calcularTotales(List<Intake> ingestas) {
  double cal = 0, pro = 0, car = 0, fat = 0;

  for (var i in ingestas) {
    cal += i.calories;
    pro += i.protein;
    car += i.carbs;
    fat += i.fat;
  }

  return {
    "calorias": cal,
    "proteinas": pro,
    "hidratos": car,
    "grasas": fat,
  };
}
