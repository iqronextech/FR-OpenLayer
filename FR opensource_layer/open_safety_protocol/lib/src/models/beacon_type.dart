/// Category of safety distress signal emitted by a mobile device or IoT node.
enum BeaconType {
  /// General SOS distress triggered by a vulnerable individual or commuter.
  emergency,

  /// Child-specific alert (e.g. school departure, route divergence).
  childSafety,

  /// Critical boundary breach beyond an authorized safety zone.
  perimeterBreach,

  /// Low battery or sensor heartbeat signaling device presence.
  heartbeat,
}
