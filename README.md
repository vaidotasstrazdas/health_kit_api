<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

HealthKit API allows you to read the Apple HealthKit data (based on another package - https://pub.dev/packages/health_kit_reporter ). Then, it allows you to send the data to your backend chosen.

## Features

1. Read the Apple HealthKit data.
2. Send this data to backend.

## Getting started

Setup everything like you would to with https://pub.dev/packages/health_kit_reporter . Then, use this library as shown in example below (or in the longer one).

## Usage

```dart
/*
* 1. Initialization
*/
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

/*
* 2. Requesting authorization.
*/
await _reporting.requestReadAuthorization();

/*
* 3. Initializing user integration.
*/
final integrationResult = await _api.initIntegration(
  authToken: _authToken,
  clientId: _clientId,
);

/*
* 4. Reading Apple HealthKit data
*/
final appleData = await _reporting.readActivityData(
  from: DateTime(2022, 09, 22),
  to: DateTime.now(),
);

/*
* 5. Sending Apple HealthKit data to your backend.
*/
await _api.sendData(
  authToken: _authToken,
  request: DataRequest(
    records: appleData,
    userId: integrationResult.userId,
  ),
);
```

## Additional information

All information is here and in the GitHub page of this package.
