library health_kit_api;

class DataRequestRecord {
  final String? date;
  final double? activityMoveMode;
  final double? appleMoveTime;
  final double? activeEnergyBurned;
  final double? appleExerciseTime;
  final int? steps;
  final double? calories;
  final Iterable<double>? heartRate;
  final Iterable<double>? restingHeartRate;

  const DataRequestRecord({
    this.date,
    this.activityMoveMode,
    this.appleMoveTime,
    this.activeEnergyBurned,
    this.appleExerciseTime,
    this.steps,
    this.calories,
    this.heartRate,
    this.restingHeartRate,
  });

  Map<String, dynamic> toObject() => {
        'date': date,
        'activityMoveMode': activityMoveMode,
        'appleMoveTime': appleMoveTime,
        'activeEnergyBurned': activeEnergyBurned,
        'appleExerciseTime': appleExerciseTime,
        'steps': steps,
        'calories': calories,
        'heartRate': heartRate,
        'restingHeartRate': restingHeartRate,
      };
}
