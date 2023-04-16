import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleCheckpoint extends ConsumerWidget {
  const SingleCheckpoint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/Checkpoint.png',
            height: 18,
            width: 18,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Checkpoint 1',
            style: context.theme.textTheme.titleMedium!.copyWith(
              color: darkColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(child: Container()),
          Text(
            '500m',
            style: context.theme.textTheme.titleMedium!.copyWith(
              color: darkColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
