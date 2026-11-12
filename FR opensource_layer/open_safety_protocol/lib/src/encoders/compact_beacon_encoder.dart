import 'dart:convert';
import '../models/beacon_type.dart';
import '../models/distress_beacon.dart';

/// Encodes and decodes distress beacons into compact, URL-safe strings
/// for low-bandwidth GSM SMS, mesh, or satellite broadcast.
class CompactBeaconEncoder {
  static const String protocolPrefix = 'OSP1';

  /// Serializes a [DistressBeacon] into a compact, single-line string.
  /// Format: OSP1:<entityId>:<lat>:<lng>:<accuracy>:<battery>:<typeCode>:<epochSec>
  static String encode(DistressBeacon beacon) {
    final latStr = beacon.latitude.toStringAsFixed(6);
    final lngStr = beacon.longitude.toStringAsFixed(6);
    final accStr = beacon.accuracyMeters.round().toString();
    final epochSec = (beacon.timestamp.millisecondsSinceEpoch ~/ 1000).toString();
    final typeCode = beacon.type.index.toString();

    final raw = '$protocolPrefix:${beacon.entityId}:$latStr:$lngStr:$accStr:${beacon.batteryPercent}:$typeCode:$epochSec';
    return raw;
  }

  /// Deserializes a compact string back into a [DistressBeacon].
  static DistressBeacon? decode(String payload) {
    try {
      final parts = payload.trim().split(':');
      if (parts.length < 8 || parts[0] != protocolPrefix) {
        return null;
      }

      final entityId = parts[1];
      final lat = double.parse(parts[2]);
      final lng = double.parse(parts[3]);
      final acc = double.parse(parts[4]);
      final bat = int.parse(parts[5]);
      final typeIndex = int.parse(parts[6]);
      final epochSec = int.parse(parts[7]);

      final type = (typeIndex >= 0 && typeIndex < BeaconType.values.length)
          ? BeaconType.values[typeIndex]
          : BeaconType.emergency;

      final ts = DateTime.fromMillisecondsSinceEpoch(epochSec * 1000, isUtc: true);

      return DistressBeacon(
        entityId: entityId,
        latitude: lat,
        longitude: lng,
        accuracyMeters: acc,
        batteryPercent: bat,
        type: type,
        timestamp: ts,
      );
    } catch (_) {
      return null;
    }
  }
}
