import 'package:elo_byte_task/src/modules/home/view/home.view.dart';
import 'package:elo_byte_task/src/modules/set.goal/components/slider.thumb.dart';
import 'package:elo_byte_task/src/modules/set.goal/components/ui.image.gen.dart';
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
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.plusJakartaSans(
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          
          titleMedium: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium:  GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: double.infinity,
          buttonColor: const Color(0xFF20C56C),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(48),),
          height: 56,
        ),
      ),
      debugShowCheckedModeBanner: false,
      restorationScopeId: appName,
      home: const HomeView(),
    );
  }
}
