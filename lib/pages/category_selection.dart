import 'package:flutter/material.dart';
import 'package:sari/pages/add_product_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  _CategorySelectionPageState createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  final List<String> categories = [
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

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Categories'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select categories that your products belong to:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: categories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: selectedCategories.contains(category),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Save selected categories to SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.setStringList('selectedCategories', selectedCategories);

                // Navigate to the AddProductForm page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProductForm()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
