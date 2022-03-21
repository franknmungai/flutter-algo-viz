import 'package:flutter/material.dart';

class BubbleSort extends StatefulWidget {
  @override
  _BubbleSortState createState() => _BubbleSortState();
}

class _BubbleSortState extends State<BubbleSort> {
  List<int> items = List.generate(100, (index) => index + 1)..shuffle();
  int item1 = 1;
  int item2 = 1;

  Future<void> sort() async {
    for (var i = 0; i < items.length; i++) {
      for (var j = 0; j < items.length - 1 - i; j++) {
        setState(() => item2 = items[j]);
        setState(() => item1 = items[j + 1]);

        if (items[j] > items[j + 1]) {
          final temp = items[j];
          items[j] = items[j + 1];

          items[j + 1] = temp;
        }

        await Future.delayed(Duration(milliseconds: 5));
      }

      await Future.delayed(Duration(milliseconds: 10));
    }

    setState(() {
      items = items;
    });
  }

  void shuffle() {
    setState(() {
      items = items..shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Bubble sort'),
          Expanded(
            child: Row(
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
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map(
                (item) {
                  final height = (size.height * 0.6);
                  return Container(
                    height: height * (item / 100),
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
          ),
        ],
      ),
    );
  }
}
