import 'dart:async';

import 'package:flutter/material.dart';

class SelectionSort extends StatefulWidget {
  @override
  _SelectionSortState createState() => _SelectionSortState();
}

class _SelectionSortState extends State<SelectionSort> {
  List<int> items = List.generate(100, (index) => index + 1)..shuffle();
  int item1 = 1;
  int item2 = 1;
  bool sorting = false;

  Future<void> sort() async {
    setState(() => sorting = true);
    runTimer();
    for (var i = 0; i < items.length; i++) {
      var smallest = items[i];
      var index = i;

      for (var j = i + 1; j < items.length; j++) {
        setState(() => item2 = items[i]);
        setState(() => item1 = items[j]);

        if (items[j] < smallest) {
          smallest = items[j];
          index = j;
        }

        await Future.delayed(Duration(milliseconds: 5));
      }

      final temp = items[i];
      items[i] = smallest;
      items[index] = temp;

      await Future.delayed(Duration(milliseconds: 10));
    }

    setState(() {
      items = items;
    });

    setState(() => sorting = false);
    runTimer();
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
    final timer1 = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        sec = sec + 1;
      });
    });
    final timer2 = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {
        sec = 0;
        min = min + 1;
      });
    });

    if (!sorting) {
      timer1.cancel();
      timer2.cancel();
    }
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
          Text('Selection sort'),
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
