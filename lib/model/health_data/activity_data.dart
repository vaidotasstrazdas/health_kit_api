library health_kit_api;

class ActivityData {
  final String? date;
  final num? activityMoveMode;
  final num? appleMoveTime;
  final num? activeEnergyBurned;
  final num? appleExerciseTime;
  final num? steps;
  final num? calories;
  final Iterable<num>? heartRates;
  final Iterable<num>? restingHeartRates;

  const ActivityData({
    required this.date,
    required this.activityMoveMode,
    required this.appleMoveTime,
    required this.activeEnergyBurned,
    required this.appleExerciseTime,
    required this.steps,
    required this.calories,
    required this.heartRates,
    required this.restingHeartRates,
  });
}
