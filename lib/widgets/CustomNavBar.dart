import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 80,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(
          alpha: theme.colorScheme.surface.a * 0.9,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.white54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.home_outlined),
                  Positioned(
                    bottom: -8,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
