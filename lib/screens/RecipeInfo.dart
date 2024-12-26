import 'package:flutter/material.dart';
import 'package:task2/theme.dart';
import 'page2.dart';
import 'package:task2/widgets/CustomListTile.dart';
import 'package:task2/widgets/CustomStepWidget.dart';
import 'package:task2/Models/FavouritesManager.dart';
import 'package:task2/widgets/CustomDialog.dart';
import 'package:video_player/video_player.dart';

class RecipeInfo extends StatefulWidget {
  final Map<String, dynamic> recipeData;

  const RecipeInfo({Key? key, required this.recipeData}) : super(key: key);

  @override
  _RecipeInfoState createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/food.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PageTheme.getDarkTheme();
    final recipeData = widget.recipeData;
    final String dishName = recipeData['slug'] ?? 'Unknown Dish';
    const double rating = 4.8;
    const int reviewsCount = 163;
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
                      onPressed: () {
                        FavoritesManager.addToFavorites(imageUrl, dishName);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Page2()),
                        );
                      },
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  dishName: dishName,
                                  onSubmit: (String comment) {},
                                );
                              },
                            );
                          },
                          iconSize: 30,
                        )
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
                    const Divider(
                      color: PageTheme.hintColor,
                      thickness: 4,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 20),
                    CustomListTile(
                      items: ingredients,
                      title: 'Ingredients',
                      icon: Icons.restaurant_menu_rounded,
                      countLabel: 'items',
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: PageTheme.hintColor,
                      thickness: 4,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 20),
                    CustomStepWidget(
                      items: steps,
                      title: 'Steps',
                      getIcon: (index) {
                        return index % 2 == 0
                            ? Icons.format_list_numbered_rounded
                            : Icons.format_list_numbered_rtl_rounded;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: PageTheme.hintColor,
                      thickness: 4,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 20),
                    CustomListTile(
                      items: tips,
                      title: 'Tips',
                      icon: Icons.lightbulb_outline,
                      subtitle: 'Helpful hints for preparation',
                      countLabel: 'tips',
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: PageTheme.hintColor,
                      thickness: 4,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recipe Tutorial',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Video',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _videoController.value.isInitialized
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AspectRatio(
                                  aspectRatio:
                                      _videoController.value.aspectRatio,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      VideoPlayer(_videoController),
                                      VideoProgressIndicator(
                                        _videoController,
                                        allowScrubbing: true,
                                        colors: const VideoProgressColors(
                                          playedColor: PageTheme.primaryColor,
                                          backgroundColor: PageTheme.hintColor,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          _videoController.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (_videoController
                                                .value.isPlaying) {
                                              _videoController.pause();
                                            } else {
                                              _videoController.play();
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ],
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
