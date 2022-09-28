import 'package:health_kit_api/model/health_data/activity_data.dart';
import 'package:health_kit_api/model/utils/date_util.dart';
import 'package:health_kit_reporter/health_kit_reporter.dart';
import 'package:health_kit_reporter/model/predicate.dart';
import 'package:health_kit_reporter/model/type/quantity_type.dart';

class HealthKitReporting {
  Future<bool> requestReadAuthorization() async {
    final readTypes = <String>[];
    readTypes.addAll(QuantityType.values.map((e) => e.identifier));

    return HealthKitReporter.requestAuthorization(readTypes, []);
  }

  Future<List<ActivityData>> readActivityData({
    required DateTime from,
    required DateTime to,
  }) async {
    final preferredUnits = await HealthKitReporter.preferredUnits([
      QuantityType.appleExerciseTime,
      QuantityType.stepCount,
      QuantityType.activeEnergyBurned,
      QuantityType.heartRate,
      QuantityType.restingHeartRate,
    ]);

    final mappedByDate = <String, ActivityData>{};
    for (final unit in preferredUnits) {
      final type = QuantityTypeFactory.from(unit.identifier);
      final quantities = await HealthKitReporter.quantityQuery(
        type,
        unit.identifier,
        Predicate(from, to),
      );

      for (final quantity in quantities) {
        final date = DateUtil.millisToDateString(quantity.startTimestamp);
        if (mappedByDate[date] == null) {
          mappedByDate[date] = ActivityData(
            date: DateTime.parse(date),
          );
        }

        mappedByDate[date] = mappedByDate[date]!.merge(
          _getData(type, quantity.harmonized.value),
        );
      }
    }

    final result = mappedByDate.entries.map((e) => e.value).toList();
    return result;
  }

  ActivityData _getData(QuantityType type, num value) {
    switch (type) {
      case QuantityType.appleExerciseTime:
        return ActivityData(appleExerciseTime: value, appleMoveTime: value);
      case QuantityType.stepCount:
        return ActivityData(steps: value);
      case QuantityType.activeEnergyBurned:
        return ActivityData(calories: value);
      case QuantityType.heartRate:
        return ActivityData(heartRates: [value]);
      case QuantityType.restingHeartRate:
        return ActivityData(restingHeartRates: [value]);
      default:
        return const ActivityData();
    }
  }
}
