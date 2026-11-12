import 'package:test/test.dart';
import 'package:open_safety_protocol/open_safety_protocol.dart';

void main() {
  group('Open Safety Protocol Suite', () {
    test('Beacon serialization and deserialization retains accuracy', () {
      final now = DateTime.utc(2026, 11, 12, 10, 0, 0);
      final original = DistressBeacon(
        entityId: 'NODE-101',
        latitude: 31.520370,
        longitude: 74.358747,
        accuracyMeters: 10.0,
        batteryPercent: 85,
        type: BeaconType.emergency,
        timestamp: now,
      );

      final encoded = CompactBeaconEncoder.encode(original);
      expect(encoded.startsWith('OSP1:NODE-101:'), isTrue);

      final decoded = CompactBeaconEncoder.decode(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.entityId, equals('NODE-101'));
      expect(decoded.latitude, closeTo(31.520370, 0.0001));
      expect(decoded.longitude, closeTo(74.358747, 0.0001));
      expect(decoded.batteryPercent, equals(85));
      expect(decoded.type, equals(BeaconType.emergency));
    });

    test('SafePerimeter correctly evaluates coordinate inclusion', () {
      final perimeter = SafePerimeter(
        label: 'Lahore Safe Hub',
        centerLatitude: 31.520400,
        centerLongitude: 74.358700,
        radiusMeters: 500.0,
      );

      // Point inside radius (~50 meters away)
      expect(perimeter.contains(31.520450, 74.358750), isTrue);

      // Point far outside radius (~5 kilometers away)
      expect(perimeter.contains(31.570000, 74.400000), isFalse);
    });
  });
}
