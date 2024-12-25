import 'package:flutter/material.dart';
import 'package:task2/theme.dart';

class CustomDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final VoidCallback onSubmit;

  CustomDialog({Key? key, required this.onSubmit}) : super(key: key);

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
            borderSide:
                const BorderSide(color: PageTheme.primaryColor, width: 2),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: PageTheme.accentColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onSubmit();
            Navigator.of(context).pop(); // Close the dialog
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
