import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'Page 3',
              style: TextStyle(fontSize: 30),
            ),
            Icon(Icons.message_outlined, size: 50, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
