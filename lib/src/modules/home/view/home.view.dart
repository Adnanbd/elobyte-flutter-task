import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:elo_byte_task/src/modules/set.goal/views/set.goal.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: slateGreyColor,
      body: SizedBox(
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
                  SvgPicture.asset('assets/Theme.svg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Set your walking goal today!',
                style: context.theme.textTheme.headlineLarge!.copyWith(
                  color: darkColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset('assets/Image.png'),
                    Positioned(
                      bottom: 20,
                      child: SizedBox(
                        width: context.width * .8,
                        child: MaterialButton(
                          onPressed: () {
                            context.push(const SetGoalView());
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
            ),
          ],
        )),
      ),
    );
  }
}
