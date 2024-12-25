import 'package:flutter/material.dart';
import 'package:task2/theme.dart';
import 'package:task2/widgets/FavouriteItem.dart';
import 'package:task2/Models/FavouritesManager.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
                    icon: const Icon(Icons.arrow_back,
                        color: PageTheme.lightTextColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 68.0),
                    child: Text(
                      'Your Top Picks',
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FavoritesManager.favoriteDishes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: PageTheme.primaryColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No favourites yet',
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
                              'Start adding your favorite dishes!',
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
                        itemCount: FavoritesManager.favoriteDishes.length,
                        itemBuilder: (context, index) {
                          final dish = FavoritesManager.favoriteDishes[index];
                          return FavouriteItem(
                            imageUrl: dish['imageUrl'],
                            dishName: dish['dishName'],
                            rating: dish['rating'],
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
