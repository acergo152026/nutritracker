import 'app_db.dart';

extension IntakeDAO on AppDatabase {
  Future<int> addIntake({
    required String name,
    required double grams,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
  }) {
    return into(intakes).insert(
      IntakesCompanion.insert(
        name: name,
        grams: grams,
        calories: calories,
        protein: protein,
        carbs: carbs,
        fat: fat,
        date: DateTime.now(),
      ),
    );
  }

  Stream<List<Intake>> watchToday() {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);

    return (select(intakes)
          ..where((t) => t.date.isBiggerOrEqualValue(start)))
        .watch()
        .map((rows) => rows
            .map((r) => Intake(
                  id: r.id,
                  name: r.name,
                  grams: r.grams,
                  calories: r.calories,
                  protein: r.protein,
                  carbs: r.carbs,
                  fat: r.fat,
                  date: r.date,
                ))
            .toList());
  }
}
