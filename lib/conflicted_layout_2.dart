import 'package:flutter/material.dart';

class ConflictedLayout2 extends StatelessWidget {
  const ConflictedLayout2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Debugging 2'),
      ),
      body: Column(
        // Use ListView for the entire list
        children: [
          const Text('Top Content'),
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              // Inner list within a list item (optional)
              itemCount: 100,
              itemBuilder: (context, index) => Text('Top Items $index'),
            ),
          ),
          const Text('More Content'),
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              // Inner list within a list item (optional)
              itemCount: 100,
              itemBuilder: (context, index) => Text('More Item $index'),
            ),
          ),
          const Text('Load more'),
        ],
      ),
    );
  }
}
