import 'package:flutter/material.dart';
import 'package:task2/theme.dart';
import 'package:task2/Models/ReviewsManager.dart';
import 'package:task2/screens/page3.dart';

class CustomDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final Function(String) onSubmit;
  final String dishName;

  CustomDialog({
    Key? key,
    required this.onSubmit,
    required this.dishName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: PageTheme.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: const Row(
        children: [
          Icon(
            Icons.comment_bank_rounded,
            color: PageTheme.accentColor,
          ),
          SizedBox(width: 8),
          Text(
            'Add Your Comment',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PageTheme.lightTextColor,
            ),
          ),
        ],
      ),
      content: TextField(
        controller: commentController,
        maxLines: 4,
        style: const TextStyle(color: PageTheme.lightTextColor),
        decoration: InputDecoration(
          hintText: 'Enter your comment here',
          hintStyle: const TextStyle(color: PageTheme.hintColor),
          filled: true,
          fillColor: PageTheme.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: PageTheme.accentColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final newComment = {
              'rating': 4,
              'text': commentController.text,
              'username': 'Nolan Shrestha',
              'time': 'Just now',
              'dishName': dishName,
            };
            ReviewsManager.addReview(newComment);
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Page3(
                  dishName: dishName,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PageTheme.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Comment'),
        ),
      ],
    );
  }
}
