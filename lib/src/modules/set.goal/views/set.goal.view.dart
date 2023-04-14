import 'dart:typed_data';

import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:elo_byte_task/src/modules/set.goal/components/slider.thumb.dart';
import 'package:elo_byte_task/src/modules/set.goal/components/ui.image.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class SetGoalView extends ConsumerStatefulWidget {
  const SetGoalView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetGoalViewState();
}

class _SetGoalViewState extends ConsumerState<SetGoalView> {
  ui.Image? customImage;
  double sliderValue = 0.0;

  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      loadImage(
        'assets/Slider-small.png',
      ).then((image) {
        setState(() {
          customImage = image;
          isLoading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: slateGreyColor,
      body: isLoading
          ? CircularProgressIndicator()
          : Column(
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
                            //SizedBox(
                            //  height: context.mediaQuery.viewPadding.top,
                            //),
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

                            Text(
                              'Set Your Walking Goal Now!',
                              style: context.theme.textTheme.headlineLarge!
                                  .copyWith(
                                color: whiteColor,
                              ),
                            ),

                            Text(
                              'Your determination and effort is inspiring. Keep pushing yourself to reach new heights.',
                              style:
                                  context.theme.textTheme.titleMedium!.copyWith(
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 10,
                    thumbShape: SliderThumbImage(customImage!),
                  ),
                  child: Slider(
                    value: sliderValue,
                    max: 1.0,
                    min: 0.0,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
