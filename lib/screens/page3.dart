import 'package:flutter/material.dart';
import 'package:task2/theme.dart';
import 'package:task2/widgets/CustomReview.dart';

class Page3 extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'rating': 4,
      'text': "The kids loved it. Next time I'm doubling the quantities!",
      'username': 'Sofi304',
      'time': '2 hours ago',
    },
    {
      'rating': 3,
      'text': 'Needs salt!',
      'username': 'CrunchyBTS',
      'time': '5 hours ago',
    },
    {
      'rating': 2,
      'text': "Not my thing. Too salty, and I like to complain about stuff!",
      'username': 'ToothpickMailbox',
      'time': '5 days ago',
    },
    {
      'rating': 4,
      'text':
          'Try adding a finely diced brown onion for a different (more traditional?) take.',
      'username': 'OnionGenius',
      'time': '6 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: PageTheme.backgroundColor,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return CustomReview(
              rating: review['rating'],
              text: review['text'],
              username: review['username'],
              time: review['time'],
            );
          },
        ),
      ),
    );
  }
}
