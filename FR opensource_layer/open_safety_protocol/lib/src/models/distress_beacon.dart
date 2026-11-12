import 'beacon_type.dart';

/// An immutable distress beacon representing an individual's emergency state.
class DistressBeacon {
  /// Unique identifier of the transmitting entity or device token.
  final String entityId;

  /// Latitude in decimal degrees (-90.0 to 90.0).
  final double latitude;

  /// Longitude in decimal degrees (-180.0 to 180.0).
  final double longitude;

  /// Estimated accuracy radius in meters.
  final double accuracyMeters;

  /// Remaining device battery percentage (0 to 100).
  final int batteryPercent;

  /// Primary category of the beacon.
  final BeaconType type;

  /// Coordinated Universal Time (UTC) timestamp when beacon was recorded.
  final DateTime timestamp;

  const DistressBeacon({
    required this.entityId,
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
    required this.batteryPercent,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'entityId': entityId,
        'lat': latitude,
        'lng': longitude,
        'acc': accuracyMeters,
        'bat': batteryPercent,
        'type': type.name,
        'ts': timestamp.toIso8601String(),
      };

  factory DistressBeacon.fromJson(Map<String, dynamic> json) => DistressBeacon(
        entityId: json['entityId'] as String? ?? 'unknown',
        latitude: (json['lat'] as num).toDouble(),
        longitude: (json['lng'] as num).toDouble(),
        accuracyMeters: (json['acc'] as num?)?.toDouble() ?? 0.0,
        batteryPercent: (json['bat'] as num?)?.toInt() ?? 100,
        type: BeaconType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => BeaconType.emergency,
        ),
        timestamp: DateTime.parse(json['ts'] as String),
      );
}
