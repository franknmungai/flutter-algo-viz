import 'dart:async';
import 'package:algo_viz/constants/styles.dart';
import 'package:flutter/material.dart';

class MergeSort extends StatefulWidget {
  @override
  _MergeSortState createState() => _MergeSortState();
}

class _MergeSortState extends State<MergeSort> {
  List<int> items = List.generate(150, (index) => index + 1)..shuffle();
  int item1 = 1;
  int item2 = 1;
  bool sorting = false;

  Future<void> sort() async {
    setState(() => sorting = true);
    runTimer();
    await mergeSort(items);
    setState(() => sorting = false);
  }

  // merge two sorted arrays
  Future<List<int>> merge(List<int> left, List<int> right) async {
    List<int> result = [];

    while (left.length > 0 && right.length > 0) {
      setState(() => item1 = left[0]);
      setState(() => item2 = right[0]);

      await Future.delayed(Duration(milliseconds: 5));

      if (left[0] < right[0]) {
        result.add(left.removeAt(0));
      } else {
        result.add(right.removeAt(0));
      }
    }

    if (left.length > 0) {
      result.addAll(left);
    }
    if (right.length > 0) {
      result.addAll(right);
    }

    items.removeWhere((item) => result.contains(item));
    setState(() => items = items);

    // items.insertAll(right.length, result);
    items.insertAll(0, result);
    await Future.delayed(Duration(milliseconds: 10));

    return result;
  }

  Future<List<int>> mergeSort(List<int> items) async {
    if (items.length == 1) {
      return items;
    }
    int midpoint = (items.length / 2).round();

    List<int> left = items.sublist(0, midpoint);
    List<int> right = items.sublist(midpoint);

    return merge(await mergeSort(left), await mergeSort(right));
  }

  void shuffle() {
    if (sorting) return;
    setState(() {
      items = items..shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int min = 0;
  int sec = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void runTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!sorting) {
        timer.cancel();
        timer.cancel();
      }
      setState(() {
        sec = sec + 1;
      });
    });
    Timer.periodic(Duration(seconds: 60), (timer) {
      if (!sorting) {
        timer.cancel();
        timer.cancel();
      }
      setState(() {
        sec = 0;
        min = min + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Merge sort',
            style: heading1,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(onPressed: sort, title: 'Sort'),
              CustomButton(
                onPressed: shuffle,
                color: Colors.pink,
                title: 'Shuffle',
              ),
              CounterText(count: min),
              CounterText(count: min),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: items.map(
              (item) {
                return Container(
                  height: (size.height * 0.6) * item / 150,
                  width: size.width / 300,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: item1 == item
                        ? Colors.green
                        : item2 == item
                            ? Colors.red
                            : Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

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

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Color? color;
  final String title;

  CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? Colors.purple.shade400,
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 16, horizontal: 48),
          ),
        ),
      ),
    );
  }
}
