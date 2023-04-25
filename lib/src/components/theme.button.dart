import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/modules/home/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ThemeButton extends ConsumerWidget {
  final Color? color;
  const ThemeButton({super.key, this.color = accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(isDarkTheme.notifier).update((state) => !state),
      child: SvgPicture.asset(
        'assets/Theme.svg',
        color: color,
      ),
    );
  }
}
