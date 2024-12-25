class FavoritesManager {
  static final List<Map<String, dynamic>> favoriteDishes = [];

  static void addToFavorites(String imageUrl, String dishName) {
    if (!favoriteDishes.any((dish) => dish['dishName'] == dishName)) {
      favoriteDishes.add({
        'imageUrl': imageUrl,
        'dishName': dishName,
        'rating': 4.8,
      });
    }
  }
}
