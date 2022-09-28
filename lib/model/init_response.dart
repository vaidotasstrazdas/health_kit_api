library health_kit_api;

class InitResponse {
  final String userId;

  const InitResponse({
    required this.userId,
  });

  factory InitResponse.fromJson(Map<String, dynamic> json) {
    return InitResponse(
      userId: json['user_uuid'],
    );
  }
}
