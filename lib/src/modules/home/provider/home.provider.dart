import 'dart:async';

import 'package:elo_byte_task/src/db/firestore.db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_device_id/platform_device_id.dart';

final totalDistanceFetch =
    AsyncNotifierProvider.family<TotalDistanceNotifier, double, String>(
  () => TotalDistanceNotifier(),
);

class TotalDistanceNotifier extends FamilyAsyncNotifier<double, String> {
  @override
  FutureOr<double> build(String arg) {
    return FirestoreDB().getTotalDistance(arg);
  }
}


final deviceIdNewProvider =
    AsyncNotifierProvider<DeviceIdNotifier, String?>(
  () => DeviceIdNotifier(),
);

class DeviceIdNotifier extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return PlatformDeviceId.getDeviceId;
  }
}




final isDarkTheme = StateProvider<bool>((ref) {
  return false;
});