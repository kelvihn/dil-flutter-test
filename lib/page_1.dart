import 'package:flutter/material.dart';

import 'page_2.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: TextButton(
        onPressed: goToNextPage,
        child: const Text("Go to next page"),
      ),
    );
  }

  goToNextPage() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageTwo()));
}
