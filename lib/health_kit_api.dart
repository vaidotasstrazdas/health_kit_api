library health_kit_api;

import 'dart:convert';

import 'package:health_kit_api/model/exceptions/api_exception.dart';
import 'package:health_kit_api/model/health_data/data_request.dart';
import 'package:health_kit_api/model/health_data/data_response.dart';
import 'package:health_kit_api/model/init_response.dart';
import 'package:http/http.dart' as http;
import 'package:health_kit_api/model/origin.dart';

class HealthKitApi {
  static final _client = http.Client();
  final Origin origin;

  const HealthKitApi({
    required this.origin,
  });

  Future<InitResponse> initIntegration({
    required String clientId,
    required String authToken,
  }) async {
    final endpoint = Uri.parse('${origin.host}/init-user-integration');

    final response = await _client.post(
      endpoint,
      body: {
        'client_id': clientId,
        'auth_token': authToken,
        'provider': 'apple',
        'user_id': origin.userId
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': origin.userId,
      },
    );

    if (response.statusCode != 200) {
      throw ApiException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final responseBodyJson = jsonDecode(response.body);
    final result = InitResponse.fromJson(responseBodyJson);

    return result;
  }

  Future<DataResponse> sendData({
    required String authToken,
    required DataRequest request,
  }) async {
    final endpoint = Uri.parse('${origin.host}/sync/apple/');

    final requestObject = request.toObject();
    final requestJson = jsonEncode(requestObject);

    final response = await _client.post(
      endpoint,
      body: requestJson,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Spike-Auth': authToken,
      },
    );

    if (response.statusCode != 200) {
      throw ApiException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final responseObject = jsonDecode(utf8.decode(response.bodyBytes));
    final result = DataResponse.fromObject(responseObject);

    return result;
  }
}
