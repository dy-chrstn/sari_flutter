import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dpController = TextEditingController();
  TextEditingController srpController = TextEditingController();
  File? _selectedImage;
  bool _imageSelected = false;
  String selectedCategory = 'Basic Groceries';
  File? imageFile;

  List<TextEditingController> measurementControllers = [
    TextEditingController()
  ];

  List<TextEditingController> typeControllers = [TextEditingController()];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFB3CDE4),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in the x, y direction
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: barcodeController,
                      decoration: InputDecoration(
                        labelText: 'Barcode',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF1D3F58)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Add Measurement:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1D3F58)),
                    ),
                    // Use a ListView.builder for dynamic TextField generation
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: measurementControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 4),
                            TextField(
                              controller: measurementControllers[index],
                              onChanged: (text) {
                                if (index ==
                                        measurementControllers.length - 1 &&
                                    text.isEmpty) {
                                  // Remove the last TextField if it's empty
                                  measurementControllers.removeAt(index);
                                  setState(() {});
                                } else if (index ==
                                        measurementControllers.length - 1 &&
                                    text.isNotEmpty &&
                                    index < measurementControllers.length - 1) {
                                  // Add a new controller when typing in the last TextField
                                  measurementControllers
                                      .add(TextEditingController());
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Measurement',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1D3F58)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Add Type/Flavor:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1D3F58)),
                    ),
                    // Use a ListView.builder for dynamic TextField generation
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: typeControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            TextField(
                              controller: typeControllers[index],
                              onChanged: (_) {
                                if (index == typeControllers.length - 1) {
                                  // Add a new controller when typing in the last TextField
                                  typeControllers.add(TextEditingController());
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Type',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1D3F58)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: dpController,
                      decoration: InputDecoration(
                        labelText: 'DP (Distributor Price)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: srpController,
                      decoration: InputDecoration(
                        labelText: 'SRP (Suggested Retail Price)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Category',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1D3F58)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownSearch<String>(
                      dropdownButtonProps: const DropdownButtonProps(
                        padding: EdgeInsets.all(15),
                      ),
                      popupProps: const PopupProps.bottomSheet(
                        showSelectedItems: true,
                        title: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 5),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )),
                        showSearchBox: true,
                        searchDelay: Duration(milliseconds: 2),
                        searchFieldProps: TextFieldProps(),
                      ),
                      items: const [
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
                      ],
                      onChanged: print,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: _imageSelected
                              ? Image.file(
                                  _selectedImage!,
                                  width: 360,
                                  height: 220,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'lib/assets/default_image.png', // Replace with your placeholder image asset
                                  width: 360,
                                  height: 220,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton(
                            onPressed: _pickImage,
                            style: ElevatedButton.styleFrom(
                                elevation: 3,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              'Pick Image',
                              style: TextStyle(color: Color(0xFF1D3F58)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),
                    SizedBox(
                      height: 45,
                      width: 340,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D3F58),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'UPLOAD',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      width: 340,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 3,
                              backgroundColor: const Color(0xFFEEF3F9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(color: Color(0xFF1D3F58)),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _imageSelected = true;
      });
    }
  }
}
