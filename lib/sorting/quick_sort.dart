import 'dart:async';
import 'package:algo_viz/constants/styles.dart';
import 'package:algo_viz/sorting/merge_sort.dart';
import 'package:flutter/material.dart';

class QuickSort extends StatefulWidget {
  @override
  _QuickSortState createState() => _QuickSortState();
}

class _QuickSortState extends State<QuickSort> {
  List<int> items = List.generate(150, (index) => index + 1)..shuffle();
  int item1 = 1;
  int item2 = 1;
  bool sorting = false;

  Future<void> sort() async {
    setState(() => sorting = true);
    runTimer();
    quickSort(0, items.length - 1);
    print(items);
    setState(() => sorting = false);
  }

  int partition(List<int> items, int low, int high) {
    int i = low - 1;
    int pivot = items[high];

    for (var j = low; i < high; j++) {
      if (items[j] <= pivot) {
        i++;
        final temp = items[i];
        items[i] = items[j];
        items[j] = temp;
      }
    }

    final temp = items[i + 1];
    items[i + 1] = items[high];
    items[high] = temp;

    return i + 1;
  }

  void quickSort(int low, int high) {
    if (low < high) {
      int pi = partition(items, low, high);
      quickSort(low, pi - 1);
      quickSort(pi + 1, high);
    }
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
