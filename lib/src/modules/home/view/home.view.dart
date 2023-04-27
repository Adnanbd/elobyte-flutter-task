import 'package:elo_byte_task/src/components/theme.button.dart';
import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:elo_byte_task/src/modules/congrats/view/congrats.view.dart';
import 'package:elo_byte_task/src/modules/home/provider/home.provider.dart';
import 'package:elo_byte_task/src/modules/set.goal/views/set.goal.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_device_id/platform_device_id.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    initNotification();
  }

  initNotification() async {
    // initialize the plugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
        context.push(
          CongratsView(
            deviceId: await PlatformDeviceId.getDeviceId,
            isComplete: true,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ref.watch(isDarkTheme)
          ? context.theme.scaffoldBackgroundColor
          : slateGreyColor,
      body: ref.watch(deviceIdNewProvider).when(
        data: (id) {
          print('DeviceId = $id');
          if (id != null) {
            //ref.watch(totalDistanceFetch(id)).when(data: (data) {
            //  print('data ======== $data');
            //  if (data > 0.0) {
            //    //ref.read(totalDistanceProvider.notifier).state = data;
            //    context.push(CheckPointView(
            //      deviceID: id,
            //    ));
            //  } else {
            return SizedBox(
              height: context.height,
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: context.mediaQuery.viewPadding.top,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/Logo 1.png',
                          height: 16,
                          fit: BoxFit.contain,
                        ),
                        const ThemeButton(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Set your walking goal today!',
                      style: context.theme.textTheme.headlineLarge,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        //assets/Dark_Image.png
                        ref.watch(isDarkTheme)
                            ? Image.asset('assets/Image_darkk.png')
                            : Image.asset('assets/Image.png'),
                        Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: context.width * .8,
                            child: MaterialButton(
                              onPressed: () {
                                //_showNotification();
                                context.push(SetGoalView(
                                  deviceId: id,
                                ));
                              },
                              color: const Color(0xFF20C56C),
                              elevation: 0,
                              child: const Text(
                                'Get Started',
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            );
            //    }
            //    return null;
            //  }, error: (e, t) {
            //    return Center(
            //      child: Text(
            //        'Error $e',
            //        style: const TextStyle(color: darkColor),
            //      ),
            //    );
            //  }, loading: () {
            //    return const Center(
            //      child: SizedBox(
            //        height: 100,
            //        width: 100,
            //        child: CircularProgressIndicator(
            //          color: accentColor,
            //        ),
            //      ),
            //    );
            //  });
            //} else {
            //  return const Center(
            //      child: Text(
            //    'No Device Id Found!',
            //    style: TextStyle(color: darkColor),
            //  ));
            //}
            //return null;
            //},
          }
          return null;
        },
        error: (e, r) {
          return Center(
              child: Text(
            '$e',
            style: const TextStyle(color: accentColor),
          ));
        },
        loading: () {
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                color: accentColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
