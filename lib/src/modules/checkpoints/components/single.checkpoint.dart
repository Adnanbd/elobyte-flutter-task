import 'package:elo_byte_task/src/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleCheckpoint extends ConsumerWidget {
  final double value;
  final int index;
  const SingleCheckpoint({
    super.key,
    required this.value,
    required this.index,
  });

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
            'Checkpoint ${index + 1}',
            style: context.theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(child: Container()),
          Text(
            '${value.floor()}m',
            style: context.theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
