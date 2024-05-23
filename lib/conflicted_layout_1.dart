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
        itemBuilder: (context, index) {
          return buildItemList(index);
        },
      ),
    );
  }

  Widget buildItemList(int index) {
    return ListTile(
      title: Text('Listed Items change $index'),
    );
  }
}
