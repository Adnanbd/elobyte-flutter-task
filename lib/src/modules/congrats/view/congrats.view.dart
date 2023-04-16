import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:elo_byte_task/src/modules/set.goal/views/set.goal.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CongratsView extends ConsumerWidget {
  const CongratsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String msgA = 'Applause to Your Effort, Try Harder Next Time.';
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: context.height * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Logo 1.png',
                          height: 16,
                          fit: BoxFit.contain,
                        ),
                        SvgPicture.asset(
                          'assets/Theme.svg',
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/Congrats.png',
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      msgA,
                      style: context.theme.textTheme.headlineLarge!.copyWith(
                        color: accentColor,
                      ),
                    ),
                    Text(
                      'Your determination and effort is inspiring. Keep pushing yourself to reach new heights.',
                      style: context.theme.textTheme.titleMedium!.copyWith(
                        color: darkColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              SizedBox(
                width: context.width * .9,
                child: MaterialButton(
                  onPressed: () {
                    context.pushAndRemoveUntil(const SetGoalView());
                  },
                  color: const Color(0xFF20C56C),
                  elevation: 0,
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
