import 'package:flutter_test/flutter_test.dart';
import 'package:health_kit_api/health_kit_api.dart';
import 'package:health_kit_api/model/health_data/activity_data.dart';
import 'package:health_kit_api/model/health_data/data_request.dart';
import 'package:health_kit_api/model/origin.dart';

void main() {
  const _api = HealthKitApi(
    origin: Origin(
      host: 'https://dev.api.spikeapi.com',
      userId: 'jasbdhasbfashfj',
    ),
  );

  test('HealthKitApi: Init integration', () async {
    // Act
    final result = await _api.initIntegration(
      clientId: 'ea9e03f5-be45-49fb-bf4c-47a88c184c3b',
      authToken: 'fa0b3803-6068-4ea7-9788-eccce210d30c',
    );

    // Assert
    expect(result.userId, equals('8c390f68-167b-421f-bed2-e61a78b5b3e2'));
  });

  test('HealthKitApi: Send data', () async {
    // Act
    final now = DateTime.now();
    final result = await _api.sendData(
      authToken: 'fa0b3803-6068-4ea7-9788-eccce210d30c',
      request: DataRequest(
        records: [
          ActivityData(
            activeEnergyBurned: 3000,
            steps: 0,
            restingHeartRates: [99, 55, 44.58],
            heartRates: [85, 66.7],
            appleMoveTime: 10,
            date: now,
            appleExerciseTime: 20,
          ),
        ],
        userId: '8c390f68-167b-421f-bed2-e61a78b5b3e2',
      ),
    );

    // Assert
    expect(result.startDate?.year, equals(now.year));
    expect(result.startDate?.month, equals(now.month));
    expect(result.startDate?.day, equals(now.day));
    expect(result.endDate?.year, equals(now.year));
    expect(result.endDate?.month, equals(now.month));
    expect(result.endDate?.day, equals(now.day));
    expect(result.type, equals('activities_summary'));
    expect(result.userKey, equals('8c390f68-167b-421f-bed2-e61a78b5b3e2'));

    expect(result.sources.length, equals(1));
    expect(result.sources.elementAt(0).name, equals('apple'));

    expect(result.records.length, equals(1));
    final record = result.records.elementAt(0);
    expect(record.averageHeartRate, equals(75));
    expect(record.averageStressLevel, equals(0));
    expect(record.caloriesActive, equals(3000));
    expect(record.caloriesBaseMetabolicRate, equals(0));
    expect(record.caloriesTotal, equals(0));
    expect(record.dailyMovement, equals(10));
    expect(record.date?.year, equals(now.year));
    expect(record.date?.month, equals(now.month));
    expect(record.date?.day, equals(now.day));
    expect(record.elevation, equals(0));
    expect(record.floors, equals(0));
    expect(record.low, equals(0));
    expect(record.high, equals(0));
    expect(record.highStressDuration, equals(0));
    expect(record.lowStressDuration, equals(0));
    expect(record.maxHeartRate, equals(85));
    expect(record.minHeartRate, equals(66));
    expect(record.medium, equals(0));
    expect(record.mediumStressDuration, equals(0));
    expect(record.restingHeartRate, equals(99));
    expect(record.sedentaryMinutes, equals(0));
    expect(record.source, equals('apple'));
    expect(record.steps, equals(0));
    expect(record.stressDuration, equals(0));
  });
}
