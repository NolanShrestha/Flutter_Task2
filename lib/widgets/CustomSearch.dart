import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final Icon? leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;

  const CustomSearch({
    Key? key,
    this.leadingIcon,
    this.trailingIcon,
    required this.title,
    required this.searchController,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: leadingIcon,
        title: TextField(
          controller: searchController,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white54),
          decoration: InputDecoration(
            hintText: title,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ),
        trailing: trailingIcon,
      ),
    );
  }
}
