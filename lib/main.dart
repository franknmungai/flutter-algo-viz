import 'package:algo_viz/sorting/bubble_sort.dart';
import 'package:algo_viz/sorting/insertion_sort.dart';
import 'package:algo_viz/sorting/merge_sort.dart';
import 'package:algo_viz/sorting/quick_sort.dart';
import 'package:algo_viz/sorting/selection_sort.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            BubbleSort(),
            SelectionSort(),
            InsertionSort(),
            MergeSort(),
            QuickSort(),
          ],
        ),
      ),
    );
  }
}
