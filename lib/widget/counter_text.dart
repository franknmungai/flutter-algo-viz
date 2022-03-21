import 'package:algo_viz/constants/styles.dart';
import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  const CounterText({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        count < 10 ? '0$count' : '$count',
        style: heading1.copyWith(
          fontSize: 16,
        ),
      ),
    );
  }
}
