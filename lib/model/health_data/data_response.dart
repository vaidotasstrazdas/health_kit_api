library health_kit_api;

import 'package:health_kit_api/model/health_data/record.dart';
import 'package:health_kit_api/model/health_data/source.dart';

class DataResponse {
  final String? userKey;
  final String? startDate;
  final String? endDate;
  final Iterable<Source> sources;
  final Iterable<Record> records;

  const DataResponse({
    required this.userKey,
    required this.startDate,
    required this.endDate,
    required this.sources,
    required this.records,
  });
}
