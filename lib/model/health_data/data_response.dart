library health_kit_api;

import 'package:health_kit_api/model/health_data/record.dart';
import 'package:health_kit_api/model/health_data/source.dart';

class DataResponse {
  final String? userKey;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? type;
  final Iterable<Source> sources;
  final Iterable<Record> records;

  const DataResponse({
    required this.userKey,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.sources,
    required this.records,
  });

  factory DataResponse.fromObject(final Map<String, dynamic> object) {
    return DataResponse(
      userKey: object['user_key'],
      startDate: DateTime.tryParse(object['start_date'] ?? '')?.toLocal(),
      endDate: DateTime.tryParse(object['end_date'] ?? '')?.toLocal(),
      type: object['type'],
      sources: (object['sources'] as List<dynamic>? ?? []).map(
        (obj) => Source.fromObject(obj),
      ),
      records: (object['data'] as List<dynamic>? ?? []).map(
        (obj) => Record.fromObject(obj),
      ),
    );
  }
}
