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
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Text('Top Content'),
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => Text('Top Items $index'),
          ),
          const SliverToBoxAdapter(
            child: Text('More Content'),
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => Text('More Item $index'),
          ),
          const SliverToBoxAdapter(
            child: Text('Load more'),
          ),
        ],
      ),
    );
  }
}
