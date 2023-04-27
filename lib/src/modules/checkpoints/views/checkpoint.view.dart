import 'dart:async';
import 'dart:developer';

import 'package:elo_byte_task/src/components/theme.button.dart';
import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/db/firestore.db.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:elo_byte_task/src/modules/checkpoints/components/single.checkpoint.dart';
import 'package:elo_byte_task/src/modules/checkpoints/provider/checkpoint.provider.dart';
import 'package:elo_byte_task/src/modules/congrats/view/congrats.view.dart';
import 'package:elo_byte_task/src/modules/home/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class CheckPointView extends ConsumerStatefulWidget {
  final String deviceID;
  const CheckPointView({super.key, required this.deviceID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckPointViewState();
}

class _CheckPointViewState extends ConsumerState<CheckPointView> {
  Position? _previousLocation;
  StreamSubscription<Position>? _positionStreamSubscription;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirestoreDB().getAllCheckPoints(widget.deviceID, ref);
      ref.read(totalDistanceProvider.notifier).state = 0.0;

      getPermissionRequest().then((value) {
        _initGeolocator();
      });

      // request permission to show notifications
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
              'channel123', // id
              'High Importance Notifications', // title
              'This channel is used for important notifications.', // description
              importance: Importance.high,
              playSound: true));

      // Add Your Code here.
    });
  }

  Future<void> getPermissionRequest() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print('Location permissions are permanently denied');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  void _initGeolocator() {
    const LocationSettings locationOptions = LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 1, // Update location every 10 meters
    );

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationOptions)
            .listen((Position position) {
      // Calculate distance between previous and current location
      if (_previousLocation != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          _previousLocation!.latitude,
          _previousLocation!.longitude,
          position.latitude,
          position.longitude,
        );

        ref
            .read(totalDistanceProvider.notifier)
            .update((state) => state + distanceInMeters);

        if (ref.read(getTargetProvider(widget.deviceID)).hasValue) {
          log('Has Value >');
          double targetValue = ref
              .read(getTargetProvider(widget.deviceID))
              .asData
              ?.value['target'];
          if (targetValue < ref.read(totalDistanceProvider)) {
            log('COMPLETED ======!!!!!!!!!!!!!!!');
            _showNotification(targetValue.toString());
            _positionStreamSubscription?.cancel();
          } else {
            log('Not Completed - Target> $targetValue - Current> ${ref.read(totalDistanceProvider)}');
          }
        }

        FirestoreDB()
            .setTotalDistance(ref.read(totalDistanceProvider), widget.deviceID);
      }

      _previousLocation = position;
    });
  }

  double getLevel(double value, double target) {
    double highestValue = context.height * .22;

    return (value * highestValue) / target;
  }

  Future<void> _showNotification(String target) async {
    // Define the notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel123',
      'Show Notification Channel',
      'Channel for showing notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        'Target Completed',
        'You covered ${target}m - WalkMate',
        platformChannelSpecifics,
        payload: 'SecretCodee');
  }

  @override
  Widget build(BuildContext context) {
    final dId = widget.deviceID;
    List<double> allCheckpoints = ref.watch(allCheckpointsProvider);
    final isDark = ref.watch(isDarkTheme);
    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: context.height * .45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: accentColor,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset('assets/Pattern.png'),
                ),
                ref.watch(getTargetProvider(widget.deviceID)).when(
                  data: (data) {
                    log('TARGET GET  = ${data['target']}');
                    //print('TARGET GET  = ${data['target']}');
                    return Container(
                      height: context.height * .45,
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: context.mediaQuery.viewPadding.top,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/Logo 1.png',
                                  height: 16,
                                  fit: BoxFit.contain,
                                  color: whiteColor,
                                ),
                                ThemeButton(
                                  color: isDark ? darkColor : whiteColor,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          height: context.height * .22,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: whiteColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: getLevel(
                                              ref.watch(totalDistanceProvider),
                                              data['target']),
                                          width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: whiteColor,
                                              width: 1,
                                            ),
                                            //borderRadius: BorderRadius.circular(12),
                                            color: whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  SizedBox(
                                    height: context.height * .25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Completed',
                                              style:
                                                  TextStyle(color: whiteColor),
                                            ),
                                            Text(
                                              '${ref.watch(totalDistanceProvider).floor()}m',
                                              style: context.theme.textTheme
                                                  .headlineMedium,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Target',
                                              style:
                                                  TextStyle(color: whiteColor),
                                            ),
                                            Text(
                                              '${data['target'].floor()}m',
                                              style: context.theme.textTheme
                                                  .headlineMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (e, t) {
                    return Text('Error = $e');
                  },
                  loading: () {
                    return const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        color: whiteColor,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Checkpoints'.toUpperCase(),
                    style: context.theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color:
                        ref.watch(isDarkTheme) ? slate100Color : slateGreyColor,
                    height: 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        allCheckpoints.length,
                        (index) => SingleCheckpoint(
                              value: allCheckpoints[index],
                              index: index,
                            )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: context.width * .9,
                    child: MaterialButton(
                      onPressed: () {
                        //context.push(CheckPointView());

                        FirestoreDB()
                            .addCheckPoint(ref.read(totalDistanceProvider), dId)
                            .then((value) {
                          FirestoreDB().getAllCheckPoints(dId, ref);
                        });
                      },
                      color: const Color(0xFF20C56C),
                      elevation: 0,
                      child: const Text(
                        'Add Checkpoint',
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: context.width * .9,
                    child: MaterialButton(
                      onPressed: () {
                        context.push(CongratsView(
                          deviceId: widget.deviceID,
                        ));
                      },
                      //color: const Color(0xFF20C56C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                        side: const BorderSide(
                          width: 1,
                          color: accentColor,
                        ),
                      ),
                      elevation: 0,
                      child: const Text(
                        'Mark As Completee',
                        style: TextStyle(
                          color: accentColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
