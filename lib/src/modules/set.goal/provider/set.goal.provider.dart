import 'package:flutter_riverpod/flutter_riverpod.dart';

final targetProvider = StateProvider<double>((ref) {
  return 0.0;
});

final fetchedTargetProvider = StateProvider<double>((ref) {
  return 0.0;
});

//final deviceIdProvider = StateProvider<String?>((ref) {
//  return null;
//});