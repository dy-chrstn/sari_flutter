import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MyWidget extends StatelessWidget {
  final List<String> items = [
    'Basic Groceries',
    'Beverages',
    'Bread and Pastries',
    'Canned Goods',
    'Cigarettes',
    'Household Essentials',
    'Ice Candy and Frozen Treats',
    'Instant Noodles',
    'Mobile Phone Load and Credits',
    'Personal Care Items',
    'School Supplies',
    'Snacks',
  ];

  MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        disabledItemFn: (String s) => s.startsWith('I'),
      ),
      items: const ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Menu mode",
          hintText: "country in menu mode",
        ),
      ),
      onChanged: print,
      selectedItem: "Brazil",
    );
  }
}
