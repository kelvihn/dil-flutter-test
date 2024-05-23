import 'package:flutter/material.dart';

class ConflictedLayout2 extends StatelessWidget {
  const ConflictedLayout2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Debugging 2'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: const Text('Top Content'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text('Top Items $index'),
              childCount: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: const Text('More Content'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text('More Item $index'),
              childCount: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: const Text('Load more'),
          ),
        ],
      ),
    );
  }
}
