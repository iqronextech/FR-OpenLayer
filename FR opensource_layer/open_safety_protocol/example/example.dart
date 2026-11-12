import 'package:open_safety_protocol/open_safety_protocol.dart';

void main() {
  // 1. Create a Child Safety distress beacon
  final beacon = DistressBeacon(
    entityId: 'STUDENT-402',
    latitude: 31.520370,
    longitude: 74.358747,
    accuracyMeters: 5.0,
    batteryPercent: 68,
    type: BeaconType.childSafety,
    timestamp: DateTime.now().toUtc(),
  );

  // 2. Compact encode for SMS transmission
  final encoded = CompactBeaconEncoder.encode(beacon);
  print('Compact SMS Payload: $encoded');

  // 3. Decode at responder station
  final decoded = CompactBeaconEncoder.decode(encoded);
  if (decoded != null) {
    print('Decoded Station: ${decoded.entityId} at ${decoded.latitude}, ${decoded.longitude}');
  }

  // 4. Verify safety perimeter
  final schoolZone = SafePerimeter(
    label: 'Primary School Boundary',
    centerLatitude: 31.520400,
    centerLongitude: 74.358700,
    radiusMeters: 300.0,
  );

  final inside = schoolZone.contains(beacon.latitude, beacon.longitude);
  print('Child inside safe school zone: $inside');
}
