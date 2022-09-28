import 'package:flutter_test/flutter_test.dart';
import 'package:health_kit_api/health_kit_api.dart';
import 'package:health_kit_api/model/health_data/data_request.dart';
import 'package:health_kit_api/model/health_data/data_request_record.dart';
import 'package:health_kit_api/model/health_data/record.dart';
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
    final result = await _api.sendData(
      authToken: 'fa0b3803-6068-4ea7-9788-eccce210d30c',
      request: const DataRequest(
        records: [
          DataRequestRecord(),
        ],
        userId: '8c390f68-167b-421f-bed2-e61a78b5b3e2',
      ),
    );
  });
}
