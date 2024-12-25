import 'package:flutter/material.dart';
import 'package:task2/theme.dart';
import 'package:task2/widgets/CustomReview.dart';
import 'package:task2/Models/ReviewsManager.dart';

class Page3 extends StatelessWidget {
  final String dishName;
  final Map<String, dynamic>? newComment;

  Page3({
    Key? key,
    this.dishName = 'Recipe',
    this.newComment,
  }) : super(key: key) {
    // If there's a new comment, add it to ReviewsManager
    if (newComment != null) {
      ReviewsManager.addReview(newComment!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: PageTheme.lightTextColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 95.0),
                    child: Text(
                      'Reviews',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: PageTheme.backgroundColor,
                child: ReviewsManager.reviews.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 64,
                              color: PageTheme.primaryColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No reviews yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: PageTheme.lightTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Be the first one to leave a review!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: PageTheme.hintColor,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: ReviewsManager.reviews.length,
                        itemBuilder: (context, index) {
                          final review = ReviewsManager.reviews[index];
                          return CustomReview(
                            rating: review['rating'],
                            text: review['text'],
                            username: review['username'],
                            time: review['time'],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
