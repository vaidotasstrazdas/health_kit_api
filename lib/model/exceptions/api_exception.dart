library health_kit_api;

class ApiException implements Exception {
  final int statusCode;
  final String? body;

  const ApiException({
    required this.statusCode,
    this.body,
  });
}
