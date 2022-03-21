import 'dart:async';

import 'package:flutter/material.dart';

class InsertionSort extends StatefulWidget {
  @override
  _InsertionSortState createState() => _InsertionSortState();
}

class _InsertionSortState extends State<InsertionSort> {
  List<int> items = List.generate(100, (index) => index + 1)..shuffle();
  int item1 = 1;
  int item2 = 1;
  bool sorting = false;

  Future<void> sort() async {
    setState(() => sorting = true);
    runTimer();

    for (var i = 1; i < items.length; i++) {
      // For each iteration, Get the first element (in unsorted list)
      var key = items[i];
      setState(() => item1 = key);

      //element to the left
      var j = i - 1;

      // while there is an element to the left and the current element(key) is less than the element to the left
      while (j >= 0 && key < items[j]) {
        items[j + 1] = items[j];
        j--;
        setState(() => item2 = items[j + 1]);
        await Future.delayed(Duration(milliseconds: 5));
      }

      items[j + 1] = key;

      await Future.delayed(Duration(milliseconds: 10));
    }

    setState(() => sorting = false);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Insertion sort'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: sort,
                child: Text('Sort'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.purple.shade400,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: shuffle,
                child: Text('Shuffle'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.pink,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                  ),
                ),
              ),
              Text(min < 10 ? '0$min' : '$min'),
              Text(sec < 10 ? '0$sec' : '$sec'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: items.map(
              (item) {
                return Container(
                  height: (size.height * 0.6) * item / 100,
                  width: size.width / 180,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: item == item1
                        ? Colors.pink
                        : item == item2
                            ? Colors.green
                            : Colors.blue[400],
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
