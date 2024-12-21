import 'package:flutter/material.dart';
import 'package:task2/theme.dart';

class RecipeInfo extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const RecipeInfo({Key? key, required this.recipeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = PageTheme.getDarkTheme();
    final String dishName = recipeData['slug'] ?? 'Unknown Dish';
    const double rating = 4.5;
    const int reviewsCount = 300;
    final String cookingTime = recipeData['time']?.toString() ?? '30';
    final String calories = recipeData['calories']?.toString() ?? '250';

    final String ingredientsRaw = recipeData['Ingredients'] ?? '';
    final List<String> ingredients = ingredientsRaw.isNotEmpty
        ? ingredientsRaw
            .split('\n')
            .map((e) => e.replaceFirst('- ', '').trim())
            .toList()
        : [];

    final String imageUrl = recipeData['imageUrl'] ?? 'assets/Ramen.jpg';

    final bool veganFriendly = recipeData['VeganFriendly'] ?? false;
    final bool glutenFree = recipeData['GlutenFree'] ?? false;
    final String stepsRaw = recipeData['Steps'] ?? '';
    final List<String> steps = stepsRaw.isNotEmpty
        ? stepsRaw.split('\n').map((e) => e.trim()).toList()
        : [];
    final String tipsRaw = recipeData['Tips'] ?? '';
    final List<String> tips = tipsRaw.isNotEmpty
        ? tipsRaw.split('\n').map((e) => e.trim()).toList()
        : [];

    return Theme(
      data: theme,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: PageTheme.lightTextColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: PageTheme.primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imageUrl,
                    width: 380,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          dishName,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add_comment_rounded,
                              color: PageTheme.primaryColor),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: PageTheme.accentColor, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '$rating ($reviewsCount Reviews)',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: PageTheme.hintColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.timer,
                                color: PageTheme.primaryColor, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              cookingTime,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: PageTheme.hintColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.local_fire_department,
                                color: PageTheme.accentColor, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '$calories cal',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: PageTheme.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.eco,
                              color: PageTheme.accentColor,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              veganFriendly ? 'Vegan Friendly' : 'Not Vegan',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: PageTheme.hintColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.breakfast_dining_rounded,
                              color: PageTheme.primaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              glutenFree ? 'Gluten-Free' : 'Not Gluten-Free',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: PageTheme.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ingredients',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: PageTheme.surfaceColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: const Icon(
                                Icons.restaurant_menu_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              ingredients[index],
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Steps',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: steps.length,
                      itemBuilder: (context, index) {
                        IconData stepIcon;
                        if (index % 2 == 0) {
                          stepIcon = Icons.format_list_numbered_rounded;
                        } else {
                          stepIcon = Icons.format_list_numbered_rtl_rounded;
                        }
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: PageTheme.surfaceColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                stepIcon,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              steps[index],
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Tips',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tips.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: PageTheme.surfaceColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: const Icon(
                                Icons.lightbulb_outline_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              tips[index],
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
