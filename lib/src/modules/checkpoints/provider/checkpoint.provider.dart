import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elo_byte_task/src/db/firestore.db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTargetProvider =
    AsyncNotifierProviderFamily<GetTargetNotifier, DocumentSnapshot, String>(
  () => GetTargetNotifier(),
);

class GetTargetNotifier extends FamilyAsyncNotifier<DocumentSnapshot, String> {
  @override
  FutureOr<DocumentSnapshot> build(arg) {
    return FirestoreDB().getTarget(arg);
  }
}


final totalDistanceProvider = StateProvider<double>((ref) {
  return 0.0;
});

final allCheckpointsProvider = StateProvider<List<double>>((ref) {
  return [];
});


