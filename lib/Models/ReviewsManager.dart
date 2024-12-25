class ReviewsManager {
  static final List<Map<String, dynamic>> reviews = [];

  static void addReview(Map<String, dynamic> review) {
    reviews.insert(0, review);
  }
}
