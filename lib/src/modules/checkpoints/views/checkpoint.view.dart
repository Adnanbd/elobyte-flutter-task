import 'dart:async';

import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:elo_byte_task/src/modules/checkpoints/components/single.checkpoint.dart';
import 'package:elo_byte_task/src/modules/congrats/view/congrats.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class CheckPointView extends ConsumerStatefulWidget {
  const CheckPointView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckPointViewState();
}

class _CheckPointViewState extends ConsumerState<CheckPointView> {
  double _totalDistance = 0.0;
  Position? _previousLocation;
  StreamSubscription<Position>? _positionStreamSubscription;
  @override
  void initState() {
    super.initState();
    getPermissionRequest().then((value) {
      _initGeolocator();
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

        setState(() {
          _totalDistance += distanceInMeters;
        });
      }

      _previousLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        height: context.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                Container(
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
                            SvgPicture.asset(
                              'assets/Theme.svg',
                              color: whiteColor,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Stack(
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
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  Container(
                                    height: context.height * .14,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: whiteColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              SizedBox(
                                height: context.height * .25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Completed',
                                        ),
                                        Text(
                                          '${_totalDistance.floor()}m',
                                          style: context
                                              .theme.textTheme.headlineMedium,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Target',
                                        ),
                                        Text(
                                          '5000m',
                                          style: context
                                              .theme.textTheme.headlineMedium,
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
                      color: darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: slateGreyColor,
                    height: 1,
                  ),
                  const SingleCheckpoint(),
                  const SingleCheckpoint(),
                  const SingleCheckpoint(),
                ],
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: context.width * .9,
                    child: MaterialButton(
                      onPressed: () {
                        //context.push(CheckPointView());
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
                        context.push(const CongratsView());
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
