import 'dart:math' as math;

/// Represents a geographic safety perimeter (e.g. school, safe commute shelter).
class SafePerimeter {
  final String label;
  final double centerLatitude;
  final double centerLongitude;
  final double radiusMeters;

  const SafePerimeter({
    required this.label,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.radiusMeters,
  });

  /// Calculates geodesic distance in meters using the Haversine formula.
  double distanceTo(double targetLat, double targetLng) {
    const earthRadiusMeters = 6371000.0;

    final lat1Rad = centerLatitude * math.pi / 180.0;
    final lat2Rad = targetLat * math.pi / 180.0;
    final deltaLatRad = (targetLat - centerLatitude) * math.pi / 180.0;
    final deltaLngRad = (targetLng - centerLongitude) * math.pi / 180.0;

    final a = math.sin(deltaLatRad / 2) * math.sin(deltaLatRad / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLngRad / 2) *
            math.sin(deltaLngRad / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  /// Determines whether the coordinates fall inside the designated safe perimeter.
  bool contains(double targetLat, double targetLng) {
    return distanceTo(targetLat, targetLng) <= radiusMeters;
  }
}
