import 'package:flutter/material.dart';
import 'package:sari/pages/product_details.dart';
import 'add_product_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _value = '';

  // Sample categories
  final List<String> categories = [
    'Basic Groceries',
    'Beverages',
    'Bread and Pastries',
    'Canned Goods',
    'Cigarettes',
    'Laundry Detergent',
    'Condiments'
        'Household Essentials',
    'Ice Candy and Frozen Treats',
    'Noodles',
    'Mobile Phone Load and Credits',
    'Personal Care Items',
    'School Supplies',
    'Snacks',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search overlay
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFB3CDE4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title categories
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF1D3F58),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        label: Text(categories[index]),
                        selected: _value == categories[index],
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? categories[index] : '';
                          });
                        },
                        backgroundColor: const Color(0xFFEEF3F9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        shadowColor: Colors.grey,
                        side: BorderSide.none,
                        checkmarkColor: const Color(0xFFEEF3F9),
                        selectedColor: const Color(0xFF001B2E),
                        labelStyle: TextStyle(
                          color: _value == categories[index]
                              ? const Color(0xFFEEF3F9)
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF1D3F58),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // GridView.builder for the products section
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8333,
                  ),
                  itemCount: 16, // Adjust the itemCount based on your data
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to ProductDetails screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/century.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8, top: 8),
                              child: Text(
                                '380 grams',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Century Tuna',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 3),
                              child: Text(
                                '₱49.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFC80D0D),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductForm()),
          );
        },
        backgroundColor: const Color(0xFF1D3F58),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Suggestions 1'),
          onTap: () {
            query = 'Suggestions 1';
          },
        ),
        ListTile(
          title: const Text('Suggestions 2'),
          onTap: () {
            query = 'Suggestions 2';
          },
        ),
      ],
    );
  }
}
