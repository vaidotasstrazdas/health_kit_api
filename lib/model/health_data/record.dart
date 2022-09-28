library health_kit_api;

class Record {
  final DateTime? date;
  final String? source;
  final num? caloriesBaseMetabolicRate;
  final num? caloriesTotal;
  final num? caloriesActive;
  final num? steps;
  final num? dailyMovement;
  final num? low;
  final num? medium;
  final num? high;
  final num? elevation;
  final num? restingHeartRate;
  final num? floors;
  final num? sedentaryMinutes;
  final num? minHeartRate;
  final num? averageHeartRate;
  final num? maxHeartRate;
  final num? averageStressLevel;
  final num? maxStressLevel;
  final num? stressDuration;
  final num? lowStressDuration;
  final num? mediumStressDuration;
  final num? highStressDuration;

  const Record({
    required this.date,
    required this.source,
    required this.caloriesBaseMetabolicRate,
    required this.caloriesTotal,
    required this.caloriesActive,
    required this.steps,
    required this.dailyMovement,
    required this.low,
    required this.medium,
    required this.high,
    required this.elevation,
    required this.restingHeartRate,
    required this.floors,
    required this.sedentaryMinutes,
    required this.minHeartRate,
    required this.averageHeartRate,
    required this.maxHeartRate,
    required this.averageStressLevel,
    required this.maxStressLevel,
    required this.stressDuration,
    required this.lowStressDuration,
    required this.mediumStressDuration,
    required this.highStressDuration,
  });

  factory Record.fromObject(final Map<String, dynamic> object) {
    return Record(
      date: DateTime.tryParse(object['date'] ?? '')?.toLocal(),
      source: object['source'],
      caloriesBaseMetabolicRate: object['calories_bmr'],
      caloriesTotal: object['calories_total'],
      caloriesActive: object['calories_active'],
      steps: object['steps'],
      dailyMovement: object['daily_movement'],
      low: object['low'],
      medium: object['medium'],
      high: object['high'],
      elevation: object['elevation'],
      restingHeartRate: object['resting_hr'],
      floors: object['floors'],
      sedentaryMinutes: object['sedentary_minutes'],
      minHeartRate: object['min_hr'],
      averageHeartRate: object['avg_hr'],
      maxHeartRate: object['max_hr'],
      averageStressLevel: object['avg_stress_level'],
      maxStressLevel: object['max_stress_level'],
      stressDuration: object['stress_duration'],
      lowStressDuration: object['low_stress_duration'],
      mediumStressDuration: object['medium_stress_duration'],
      highStressDuration: object['high_stress_duration'],
    );
  }
}
