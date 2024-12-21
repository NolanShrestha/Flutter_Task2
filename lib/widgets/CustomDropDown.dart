import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final Icon customButtonIcon;
  final Function(String) onItemSelected;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.customButtonIcon,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        customButton: customButtonIcon,
        items: items.map(
          (item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (String? value) {
          if (value != null) {
            onItemSelected(value);
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: theme.colorScheme.surface,
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}
