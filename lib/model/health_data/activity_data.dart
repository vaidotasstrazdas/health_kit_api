library health_kit_api;

import 'package:health_kit_api/model/utils/date_util.dart';

class ActivityData {
  final DateTime? date;
  final num? activityMoveMode;
  final num? appleMoveTime;
  final num? activeEnergyBurned;
  final num? appleExerciseTime;
  final num? steps;
  final num? calories;
  final Iterable<num>? heartRates;
  final Iterable<num>? restingHeartRates;

  const ActivityData({
    this.date,
    this.activityMoveMode,
    this.appleMoveTime,
    this.activeEnergyBurned,
    this.appleExerciseTime,
    this.steps,
    this.calories,
    this.heartRates,
    this.restingHeartRates,
  });

  Map<String, dynamic> toObject() {
    String? dateString;
    if (date != null) {
      final dateUtc = date!.toUtc();
      dateString = DateUtil.toDateString(dateUtc);
    }

    final result = {
      'date': dateString,
      'activityMoveMode': activityMoveMode,
      'appleMoveTime': appleMoveTime,
      'activeEnergyBurned': activeEnergyBurned,
      'appleExerciseTime': appleExerciseTime,
      'steps': steps,
      'calories': calories,
      'heartRate': heartRates,
      'restingHeartRate': restingHeartRates,
    };

    result.removeWhere((key, value) => value == null);

    return result;
  }

  ActivityData merge(final ActivityData data) => ActivityData(
        date: date ?? data.date,
        activityMoveMode:
            (activityMoveMode ?? 0) + (data.activityMoveMode ?? 0),
        appleMoveTime: (appleMoveTime ?? 0) + (data.appleMoveTime ?? 0),
        activeEnergyBurned:
            (activeEnergyBurned ?? 0) + (data.activeEnergyBurned ?? 0),
        appleExerciseTime:
            (appleExerciseTime ?? 0) + (data.appleExerciseTime ?? 0),
        steps: (steps ?? 0) + (data.steps ?? 0),
        calories: (calories ?? 0) + (data.calories ?? 0),
        heartRates: [...heartRates ?? [], ...data.heartRates ?? []],
        restingHeartRates: [
          ...restingHeartRates ?? [],
          ...data.restingHeartRates ?? []
        ],
      );
}
