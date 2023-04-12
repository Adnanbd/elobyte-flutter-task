import 'package:elo_byte_task/src/modules/home/view/home.view.dart';
import 'package:flutter/material.dart'
    show BuildContext, Key, MaterialApp, ThemeData, Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import 'constants/constants.dart' show appName;

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      restorationScopeId: appName,
      home: const HomeView(),
    );
  }
}
