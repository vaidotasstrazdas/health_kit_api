library health_kit_api;

class DataRequestRecord {
  final DateTime? date;
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

  Map<String, dynamic> toObject() {
    String? dateString;
    if (date != null) {
      final dateUtc = date!.toUtc();
      dateString =
          '${dateUtc.year}-${dateUtc.month.toString().padLeft(2, '0')}-${dateUtc.day.toString().padLeft(2, '0')}';
    }

    final result = {
      'date': dateString,
      'activityMoveMode': activityMoveMode,
      'appleMoveTime': appleMoveTime,
      'activeEnergyBurned': activeEnergyBurned,
      'appleExerciseTime': appleExerciseTime,
      'steps': steps,
      'calories': calories,
      'heartRate': heartRate,
      'restingHeartRate': restingHeartRate,
    };

    result.removeWhere((key, value) => value == null);

    return result;
  }
}
