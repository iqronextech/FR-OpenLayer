# Open Safety Protocol (OSP)

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Flutter%20%7C%20Dart%20%7C%20IoT-green.svg)](https://flutter.dev)

An open-source standard and client SDK for **Child, Female, and Vulnerable Individual Emergency Telemetry**. 

Developed as an initiative toward **Digital Public Goods (DPG)** for emerging markets and low-bandwidth environments, the Open Safety Protocol provides standardized data structures for:
1. Low-latency distress beacons.
2. Ultra-compact payload serialization (<90 characters) for offline GSM SMS and mesh radios.
3. Lightweight geofence perimeter validation for child school/commute safety.

---

## Key Features

* **Compact Serialization:** Encodes full GNSS coordinates, timestamp, battery level, and emergency category into a standard string payload suitable for standard 160-character cellular SMS.
* **Zero Dependency Core:** Pure Dart implementation with no heavy native or external package locks, ensuring immediate compatibility across Android, iOS, embedded Linux, and microcontroller IoT gateways.
* **Perimeter Verification:** Fast, offline geodesic spherical calculations (Haversine) for school, home, and transit safe zones.

---

## Quick Start

### 1. Constructing a Distress Beacon

```dart
import 'package:open_safety_protocol/open_safety_protocol.dart';

final beacon = DistressBeacon(
  entityId: 'CHILD-9821',
  latitude: 31.520370,
  longitude: 74.358747,
  accuracyMeters: 8.5,
  batteryPercent: 42,
  type: BeaconType.childSafety,
  timestamp: DateTime.now().toUtc(),
);
```

### 2. Low-Bandwidth Serialization (SMS / Mesh Transmission)

```dart
// Serialize to a compact string (<75 characters)
final encoded = CompactBeaconEncoder.encode(beacon);
print(encoded);
// Output: OSP1:CHILD-9821:31.520370:74.358747:9:42:1:1794503000

// Deserialize on the guardian or emergency responder side
final decoded = CompactBeaconEncoder.decode(encoded);
```

### 3. School Safety Perimeter Validation

```dart
final schoolZone = SafePerimeter(
  label: 'Govt Model School',
  centerLatitude: 31.520400,
  centerLongitude: 74.358700,
  radiusMeters: 250.0,
);

final isSafe = schoolZone.contains(beacon.latitude, beacon.longitude);
if (!isSafe) {
  // Trigger boundary departure alert
}
```

---

## Architecture & Licensing

Open Safety Protocol is released under the **Apache License 2.0** to facilitate interoperability among humanitarian agencies, emergency responders, and independent developers across UNICEF programme countries.

Maintained with conviction by **Iqronex Technologies (Pvt) Ltd**.
