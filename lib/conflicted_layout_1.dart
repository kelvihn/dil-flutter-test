import 'package:flutter/material.dart';

class ConflictedLayout extends StatelessWidget {
  final int length = 10000;

  const ConflictedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Screen Debugging 1'),
        ),
        body: ListView.builder(
          itemCount: length,
          itemBuilder: (_, index) => BuildItemList(index: index),
        ),
    );
  }
}

class BuildItemList extends StatelessWidget {
  final int index;
  const BuildItemList({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Text('Listed Items change $index ');
  }
}

