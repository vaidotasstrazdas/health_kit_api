library health_kit_api;

import 'package:health_kit_api/model/health_data/data_request_record.dart';

class DataRequest {
  final Iterable<DataRequestRecord> records;
  final String userId;
  final String? callbackUrl;
  final String? dataType;

  const DataRequest({
    required this.records,
    required this.userId,
    this.callbackUrl,
    this.dataType,
  });

  Map<String, dynamic> toObject() {
    final result = {
      'data': records.map((record) => record.toObject()).toList(),
      'user_uuid': userId,
      'data_type': dataType ?? 'activities_summary',
      'callback_url': callbackUrl ?? '',
    };

    return result;
  }
}
