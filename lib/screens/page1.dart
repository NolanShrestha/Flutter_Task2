import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task2/widgets/CustomSearch.dart';
import 'package:task2/widgets/CustomCategory.dart';
import 'package:task2/widgets/CustomRecipe.dart';
import 'package:task2/screens/page2.dart';
import 'package:task2/screens/page3.dart';
import 'package:task2/widgets/CustomNavBar.dart';
import 'package:task2/widgets/CustomDropDown.dart';
import 'package:task2/address.dart';
import 'package:task2/widgets/RecipeInfo.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int _selectedIndex = 0;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<String> dropdownItems = [];

  Future<void> fetchTypes() async {
    const url = 'http://$ip:1337/api/categories/?fields=Type';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData != null && responseData['data'] != null) {
          Set<String> uniqueTypes = Set();

          for (var item in responseData['data']) {
            if (item['Type'] != null) {
              uniqueTypes.add(item['Type']);
            }
          }

          setState(() {
            dropdownItems = uniqueTypes.toList();
          });
        } else {
          throw Exception('No data found in the response');
        }
      } else {
        throw Exception('Failed to load types: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching types: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch types: $e'),
        ),
      );
    }
  }

  List<String> regionsList = [];

  // Fetch regions function
  Future<void> fetchRegions() async {
    const url = 'http://$ip:1337/api/categories/?fields=Region';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null && responseData['data'] != null) {
          Set<String> uniqueRegions = Set();

          for (var item in responseData['data']) {
            if (item['Region'] != null) {
              uniqueRegions.add(item['Region']);
            }
          }

          setState(() {
            regionsList = uniqueRegions.toList();
          });
        } else {
          throw Exception('No data found in the response');
        }
      } else {
        throw Exception('Failed to load regions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching regions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch regions: $e'),
        ),
      );
    }
  }

  List<dynamic> categories = [];
  Future<void> fetchCategories({String query = ''}) async {
    final url =
        'http://$ip:1337/api/categories?filters[slug][\$contains]=$query&populate=*';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData is Map && responseData.containsKey('data')) {
          List<dynamic> categoriesData = responseData['data'] ?? [];

          setState(() {
            categories = categoriesData.map<Map<String, dynamic>>((item) {
              String imageUrl = 'assets/logo.png';
              String slug = 'Unknown Dish';
              String prepTime = 'Unknown Time';

              String type = 'Unknown Type';
              int calorie = 0;
              int servingSize = 0;
              bool glutenFree = false;
              bool veganFriendly = false;
              String steps = 'No steps available';
              String ingredients = 'No ingredients available';
              String tips = 'No tips available';

              if (item is Map) {
                var attributes = item['attributes'] ?? item;

                try {
                  if (attributes['Image'] != null) {
                    var imageData = attributes['Image']['data'];
                    if (imageData is List && imageData.isNotEmpty) {
                      imageUrl =
                          'http://$ip:1337${imageData[0]['attributes']['url']}';
                    } else if (imageData is Map) {
                      imageUrl =
                          'http://$ip:1337${imageData['attributes']['url']}';
                    }
                  }
                } catch (e) {
                  print('Image URL Extraction Error: $e');
                }

                slug = attributes['slug'] ?? slug;
                prepTime = attributes['PrepTime'] ?? prepTime;
                type = attributes['Type'] ?? type;
                calorie = attributes['Calorie'] ?? calorie;
                servingSize = attributes['ServingSize'] ?? servingSize;
                glutenFree = attributes['GlutenFree'] ?? glutenFree;
                veganFriendly = attributes['VeganFriendly'] ?? veganFriendly;
                steps = attributes['Steps'] ?? steps;
                ingredients = attributes['Ingredients'] ?? ingredients;
                tips = attributes['Tips'] ?? tips;
              }

              return {
                'id': item['id'] ?? 0,
                'attributes': {
                  'slug': slug,
                  'PrepTime': prepTime,
                  'Image': imageUrl,
                  'Type': type,
                  'Calorie': calorie,
                  'ServingSize': servingSize,
                  'GlutenFree': glutenFree,
                  'VeganFriendly': veganFriendly,
                  'Steps': steps,
                  'Ingredients': ingredients,
                  'Tips': tips,
                },
              };
            }).toList();
          });
        }
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch categories: $e'),
        ),
      );
    }
  }

  List<dynamic> typedRecipes = [];
  Future<void> fetchRecipesByType(String type) async {
    final url =
        'http://$ip:1337/api/categories?filters[Type]=$type&populate[Image][fields]=url';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        List<dynamic> recipeData = [];
        if (responseData is Map && responseData.containsKey('data')) {
          recipeData = responseData['data'] ?? [];
        } else if (responseData is List) {
          recipeData = responseData;
        }

        setState(() {
          typedRecipes = recipeData.map<Map<String, dynamic>>((item) {
            String imageUrl = 'assets/logo.png';
            String slug = 'Unknown Dish';
            String prepTime = 'Unknown Time';

            String type = 'Unknown Type';
            int calorie = 0;
            int servingSize = 0;
            bool glutenFree = false;
            bool veganFriendly = false;
            String steps = 'No steps available';
            String ingredients = 'No ingredients available';
            String tips = 'No tips available';

            if (item is Map) {
              var attributes = item['attributes'] ?? item;

              try {
                if (attributes['Image'] != null) {
                  var imageData = attributes['Image']['data'];
                  if (imageData is List && imageData.isNotEmpty) {
                    imageUrl =
                        'http://$ip:1337${imageData[0]['attributes']['url']}';
                  } else if (imageData is Map) {
                    imageUrl =
                        'http://$ip:1337${imageData['attributes']['url']}';
                  }
                }
              } catch (e) {
                print('Image URL Extraction Error: $e');
              }

              slug = attributes['slug'] ?? slug;
              prepTime = attributes['PrepTime'] ?? prepTime;
              type = attributes['Type'] ?? type;
              calorie = attributes['Calorie'] ?? calorie;
              servingSize = attributes['ServingSize'] ?? servingSize;
              glutenFree = attributes['GlutenFree'] ?? glutenFree;
              veganFriendly = attributes['VeganFriendly'] ?? veganFriendly;
              steps = attributes['Steps'] ?? steps;
              ingredients = attributes['Ingredients'] ?? ingredients;
              tips = attributes['Tips'] ?? tips;
            }

            return {
              'id': item['id'] ?? 0,
              'attributes': {
                'slug': slug,
                'PrepTime': prepTime,
                'Image': imageUrl,
                'Type': type,
                'Calorie': calorie,
                'ServingSize': servingSize,
                'GlutenFree': glutenFree,
                'VeganFriendly': veganFriendly,
                'Steps': steps,
                'Ingredients': ingredients,
                'Tips': tips,
              },
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipes by type: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch recipes by type: $e'),
        ),
      );
    }
  }

  void onTypeSelected(String selectedType) {
    fetchRecipesByType(selectedType);
  }

  @override
  void initState() {
    super.initState();
    fetchTypes();
    fetchRegions();
    fetchCategories();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Page1()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Page2()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Page3()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/background.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomDropdown(
                                    items: dropdownItems,
                                    customButtonIcon: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                    onItemSelected: (selectedType) {
                                      fetchRecipesByType(selectedType);
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Good morning",
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Nolan Shrestha",
                                        style:
                                            textTheme.headlineSmall?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundImage:
                                        AssetImage('assets/logo.png'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomSearch(
                                title: "Find a recipe",
                                leadingIcon: const Icon(Icons.search,
                                    color: Colors.white54),
                                trailingIcon: searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.backspace,
                                            color: Colors.redAccent),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() {
                                            searchQuery = '';
                                          });
                                          fetchCategories();
                                        },
                                      )
                                    : const Icon(Icons.tune,
                                        color: Colors.redAccent),
                                searchController: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                  fetchCategories(query: value);
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Categories",
                                style: textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: regionsList.map((region) {
                                  IconData icon;
                                  Color iconColor;

                                  switch (region) {
                                    case 'American':
                                      icon = Icons.table_restaurant_rounded;
                                      iconColor = Colors.red;
                                      break;
                                    case 'English':
                                      icon = Icons.emoji_food_beverage;
                                      iconColor = Colors.blue;
                                      break;
                                    case 'Italian':
                                      icon = Icons.local_pizza;
                                      iconColor = Colors.green;
                                      break;
                                    case 'Greek':
                                      icon = Icons.restaurant;
                                      iconColor = Colors.blueAccent;
                                      break;
                                    case 'Chinese':
                                      icon = Icons.fastfood;
                                      iconColor = Colors.pinkAccent;
                                      break;
                                    case 'Japanese':
                                      icon = Icons.rice_bowl;
                                      iconColor = Colors.orange;
                                      break;
                                    default:
                                      icon = Icons.place;
                                      iconColor = Colors.grey;
                                  }

                                  return CustomCategory(
                                    icon: icon,
                                    label: region,
                                    color: iconColor,
                                    onTap: () {
                                      print('Selected region: $region');
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Dishes for you",
                                style: textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                constraints:
                                    const BoxConstraints(minHeight: 405),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: typedRecipes.isNotEmpty
                                      ? typedRecipes.length
                                      : categories.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemBuilder: (context, index) {
                                    final category = typedRecipes.isNotEmpty
                                        ? typedRecipes[index]
                                        : categories[index];

                                    String imageUrl = 'assets/logo.png';
                                    switch (category['attributes']['slug']) {
                                      case 'Cheeseburger':
                                        imageUrl = 'assets/Cheeseburger.jpg';
                                        break;
                                      case 'Cheesecake':
                                        imageUrl = 'assets/Cheesecake.jpg';
                                        break;
                                      case 'DimSum':
                                        imageUrl = 'assets/DimSum.jpg';
                                        break;
                                      case 'Friedrice':
                                        imageUrl = 'assets/Friedrice.jpg';
                                        break;
                                      case 'Hotdogs':
                                        imageUrl = 'assets/Hotdogs.jpg';
                                        break;
                                      case 'MacNCheese':
                                        imageUrl = 'assets/MacNCheese.jpg';
                                        break;
                                      case 'Pancakes':
                                        imageUrl = 'assets/Pancakes.jpg';
                                        break;
                                      case 'PoachedEggs':
                                        imageUrl = 'assets/PoachedEggs.jpg';
                                        break;
                                      case 'Ramen':
                                        imageUrl = 'assets/Ramen.jpg';
                                        break;
                                      case 'Tiramisu':
                                        imageUrl = 'assets/Tiramisu.jpg';
                                        break;
                                      case 'Lasagna':
                                        imageUrl = 'assets/Lasagna.jpg';
                                        break;
                                      case 'Pasta':
                                        imageUrl = 'assets/Pasta.jpg';
                                        break;
                                    }

                                    return CustomRecipe(
                                      imageUrl: imageUrl,
                                      dishName: category['attributes']
                                              ['slug'] ??
                                          'Unknown Dish',
                                      rating: 4.8,
                                      reviewsCount: 163,
                                      time: category['attributes']
                                              ['PrepTime'] ??
                                          'Unknown Time',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RecipeInfo(
                                              recipeData: {
                                                'slug': category['attributes']
                                                    ['slug'],
                                                'time': category['attributes']
                                                    ['PrepTime'],
                                                'calories':
                                                    category['attributes']
                                                            ['Calorie'] ??
                                                        'Unknown Calories',
                                                'Ingredients':
                                                    category['attributes']
                                                            ['Ingredients'] ??
                                                        'No Ingredients',
                                                'imageUrl': imageUrl,
                                                'VeganFriendly':
                                                    category['attributes']
                                                            ['VeganFriendly'] ??
                                                        false,
                                                'GlutenFree':
                                                    category['attributes']
                                                            ['GlutenFree'] ??
                                                        false,
                                                'Steps': category['attributes']
                                                        ['Steps'] ??
                                                    '',
                                                'Tips': category['attributes']
                                                        ['Tips'] ??
                                                    '',
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
