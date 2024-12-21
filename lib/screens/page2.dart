import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      // Using Center widget to center the text
      child: Column(
        children: [
          Text(
            'Page 2',
            style: TextStyle(fontSize: 30),
          ),
          Icon(Icons.favorite, size: 50, color: Colors.blue),
        ],
      ),
    );
  }
}
