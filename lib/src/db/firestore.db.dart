import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elo_byte_task/src/modules/checkpoints/provider/checkpoint.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreDB {
  final db = FirebaseFirestore.instance;
  final dbName = 'elobyte-db';

  void setTarget(double target, String deviceId) async {
    final docRef = db.collection(dbName).doc(deviceId);

    await docRef.set({'target': target}, SetOptions(merge: true)).then(
        (value) => print("Set Target successfully!"),
        onError: (e) => print("Error Set Target: $e"));
  }

  Future<DocumentSnapshot> getTarget(String deviceId) async {
    final docRef = db.collection(dbName).doc(deviceId);
    return await docRef.get();
  }

  Future<void> addCheckPoint(double newCheckpoint, String deviceId) async {
    final docRef = db.collection(dbName).doc(deviceId);
    List<double> prevCheckpoints = [];
    await docRef.get().then((value) {
      if (value.exists) {
        final data = value.data() as Map<String, dynamic>;
        if (data.containsKey('checkpoints')) {
          var array = data['checkpoints']; // array is now List<dynamic>

          prevCheckpoints = List<double>.from(array);
        }
        docRef.set({
          'checkpoints': [...prevCheckpoints, newCheckpoint]
        }, SetOptions(merge: true)).then(
            (value) => print("New CheckPoint Added successfully!"),
            onError: (e) => print("Error Set New CheckPoint: $e"));
      }
    }, onError: (e) {});
  }

  void getAllCheckPoints(String deviceId, WidgetRef ref) async {
    final docRef = db.collection(dbName).doc(deviceId);
    List<double> prevCheckpoints = [];

    await docRef.get().then((value) {
      if (value.exists) {
        final data = value.data() as Map<String, dynamic>;
        if (data.containsKey('checkpoints')) {
          var array = data['checkpoints']; // array is now List<dynamic>

          prevCheckpoints = List<double>.from(array);
        }
        ref.read(allCheckpointsProvider.notifier).state = prevCheckpoints;
      }
    }, onError: (e) {});
  }

  void setTotalDistance(double totalDistance, String deviceId) async {
    final docRef = db.collection(dbName).doc(deviceId);

    await docRef
        .set({'totalDistance': totalDistance}, SetOptions(merge: true)).then(
            (value) => print("Set totalDistance successfully!"),
            onError: (e) => print("Error Set totalDistance: $e"));
  }

  Future<double> getTotalDistance(String deviceId) async {
    final docRef = db.collection(dbName).doc(deviceId);
    final snap = await docRef.get();

    final data = snap.data() as Map<String, dynamic>;

    if (data.containsKey('totalDistance')) {
      return data['totalDistance'];
    }
    return 0.0;
  }
}
