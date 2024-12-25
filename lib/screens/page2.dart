import 'package:flutter/material.dart';
import 'package:task2/theme.dart';
import 'package:task2/widgets/FavouriteItem.dart';

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
            const SizedBox(
              height: 22,
            ),
            // Add Row inside SafeArea similar to AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align items starting from left
                children: [
                  // Back button to pop the screen
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: PageTheme.lightTextColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Text with left margin to center it
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 68.0), // Left margin to push text right
                    child: Text(
                      'Your Top Picks',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  // Optionally add more widgets to the right side if needed
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    FavouriteItem(
                      imageUrl: 'assets/Cheeseburger.jpg',
                      dishName: 'Spaghetti Bolognese',
                      rating: 4.5,
                    ),
                    FavouriteItem(
                      imageUrl: 'assets/Cheeseburger.jpg',
                      dishName: 'Chicken Alfredo',
                      rating: 4.7,
                    ),
                    FavouriteItem(
                      imageUrl: 'assets/Cheeseburger.jpg',
                      dishName: 'Vegetable Stir Fry',
                      rating: 4.2,
                    ),
                    FavouriteItem(
                      imageUrl: 'assets/Cheeseburger.jpg',
                      dishName: 'Grilled Salmon',
                      rating: 4.8,
                    ),
                    FavouriteItem(
                      imageUrl: 'assets/Cheeseburger.jpg',
                      dishName: 'Beef Tacos',
                      rating: 4.6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
