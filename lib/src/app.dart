import 'package:elo_byte_task/src/constants/theme.c.dart';
import 'package:elo_byte_task/src/modules/home/provider/home.provider.dart';
import 'package:elo_byte_task/src/modules/home/view/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart' show appName;

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ref.watch(isDarkTheme) ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      restorationScopeId: appName,
      home: const HomeView(),
    );
  }
}
