import 'package:flutter/material.dart';
import 'package:task2/theme.dart';

class CustomReview extends StatelessWidget {
  final int rating;
  final String text;
  final String username;
  final String time;

  const CustomReview({
    Key? key,
    required this.rating,
    required this.text,
    required this.username,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      color: PageTheme.surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (starIndex) {
                return Icon(
                  Icons.star,
                  color: starIndex < rating
                      ? PageTheme.accentColor
                      : PageTheme.hintColor,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: PageTheme.lightTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: PageTheme.hintColor,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: PageTheme.hintColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
