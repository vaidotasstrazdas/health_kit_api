import 'package:flutter/material.dart';
import 'package:health_kit_api/health_kit_api.dart';
import 'package:health_kit_api/health_kit_reporting.dart';
import 'package:health_kit_api/model/health_data/activity_data.dart';
import 'package:health_kit_api/model/health_data/data_request.dart';
import 'package:health_kit_api/model/health_data/data_response.dart';
import 'package:health_kit_api/model/origin.dart';

// Your API credentials
const _authToken = 'fa0b3803-6068-4ea7-9788-eccce210d30c';
const _clientId = 'ea9e03f5-be45-49fb-bf4c-47a88c184c3b';
const _host = 'https://dev.api.spikeapi.com';
const _userId = 'jasbdhasbfashfj';

// Origin of the endpoint you are going to sync the data with
const _origin = Origin(
  host: _host,
  userId: _userId,
);

// API to read the data from Apple HealthKit
final _reporting = HealthKitReporting();

const _api = HealthKitApi(origin: _origin);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _authorized;
  String? _userIdSet;
  final _activityData = <ActivityData>[];
  DataResponse? _lastResponse;

  @override
  void initState() {
    super.initState();

    _authorized = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Kit Api'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Actions',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _authorize,
                        child: const Text('Authorize'),
                      ),
                      const VerticalDivider(),
                      TextButton(
                        onPressed: _initIntegration,
                        child: const Text('Init integration'),
                      ),
                      const VerticalDivider(),
                      TextButton(
                        onPressed: _readData,
                        child: const Text('Read data'),
                      ),
                      const VerticalDivider(),
                      TextButton(
                        onPressed: _sendData,
                        child: const Text('Send data'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const Text(
                'Authorization data',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Authorized',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_authorized ? 'Yes' : 'No'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Integration user ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(_userIdSet ?? 'Not integrated, yet'),
                ],
              ),
              const Divider(),
              const Text(
                'Activity data',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              if (_activityData.isEmpty) const Text('No activity data read.'),
              ..._activityData.map((data) => _getActivityDataCard(data)),
              const Divider(),
              const Text(
                'Last send data response',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              if (_lastResponse != null) const Text('Response received.'),
              if (_lastResponse == null) const Text('No response.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getActivityDataCard(ActivityData data) {
    return Container(
      color: Colors.amber,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.date?.toIso8601String() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active energy burned',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.activeEnergyBurned?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active move mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.activityMoveMode?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Apple exercise time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.appleExerciseTime?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Apple move time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.appleMoveTime?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Calories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.calories?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Heart rates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.heartRates?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Resting eart rates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.restingHeartRates?.toString() ?? 'Not set'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Steps',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.steps?.toString() ?? 'Not set'),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _authorize() async {
    final authorized = await _reporting.requestReadAuthorization();

    setState(() {
      _authorized = authorized;
    });
  }

  Future<void> _initIntegration() async {
    final result = await _api.initIntegration(
      authToken: _authToken,
      clientId: _clientId,
    );

    setState(() {
      _userIdSet = result.userId;
    });
  }

  Future<void> _readData() async {
    final result = await _reporting.readActivityData(
      from: DateTime(2022, 09, 22),
      to: DateTime.now(),
    );

    setState(() {
      _activityData.clear();
      _activityData.addAll(result);
    });
  }

  Future<void> _sendData() async {
    final result = await _api.sendData(
      authToken: _authToken,
      request: DataRequest(
        records: _activityData,
        userId: _userIdSet!,
      ),
    );

    setState(() {
      _lastResponse = result;
    });
  }
}
