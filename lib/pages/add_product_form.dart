import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm>
    with SingleTickerProviderStateMixin {
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

  TabController? _tabController;

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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Information'),
            Tab(text: 'Prices'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Page 1: Existing form for measurements and flavors
          Container(
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
                        offset:
                            const Offset(0, 3), // Offset in the x, y direction
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
                        //Key information
                        const Text(
                          'Key Information',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1D3F58)),
                        ),
                        const SizedBox(
                          height: 6,
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
                        const SizedBox(height: 10),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        //add measurement and button
                        const SizedBox(height: 16),
                        const Divider(),
                        Row(
                          children: [
                            const Text(
                              'Add Measurement:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1D3F58)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: InkWell(
                                onTap: () => _showInstructionDialog(),
                                child: SvgPicture.asset(
                                  'lib/assets/question_mark.svg',
                                  color: const Color(0xFF1D3f58),
                                ),
                              ),
                            )
                          ],
                        ),

                        //measurement textfield
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: measurementControllers.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(height: 10),
                                TextField(
                                  controller: measurementControllers[index],
                                  onChanged: (text) {
                                    if (index ==
                                        measurementControllers.length - 1) {
                                      // Add a new controller when typing in the last TextField
                                      measurementControllers
                                          .add(TextEditingController());
                                      setState(() {});
                                    }
                                    if (text.isEmpty &&
                                        measurementControllers.length > 1) {
                                      // Remove the last TextField if it's empty and not the only one
                                      measurementControllers.removeAt(index);
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
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Add Type/Flavor:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1D3F58)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: InkWell(
                                onTap: () => _showTypeFlavorDialog(),
                                child: SvgPicture.asset(
                                  'lib/assets/question_mark.svg',
                                  color: const Color(0xFF1D3f58),
                                ),
                              ),
                            )
                          ],
                        ),

                        // Use a ListView.builder for dynamic TextField generation
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: typeControllers.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: typeControllers[index],
                                        onChanged: (text) {
                                          if (index ==
                                              typeControllers.length - 1) {
                                            // Add a new controller when typing in the last TextField
                                            typeControllers
                                                .add(TextEditingController());
                                            setState(() {});
                                          }
                                          if (text.isEmpty &&
                                              typeControllers.length > 1) {
                                            // Remove the last TextField if it's empty and not the only one
                                            typeControllers.removeAt(index);
                                            setState(() {});
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Type',
                                          //suffixIcon: const Icon(Icons.delete),

                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFF1D3F58)),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
          // Page 2: Page for setting prices
          _buildPriceSettingPage(),
        ],
      ),
    );
  }

  Widget _buildPriceSettingPage() {
    // Retrieve measurements and flavors from the first page
    List<String> measurements =
        measurementControllers.map((controller) => controller.text).toList();
    List<String> flavors =
        typeControllers.map((controller) => controller.text).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Setting Prices',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1D3F58),
            ),
          ),
          const SizedBox(height: 16),
          // Display the measurements and flavors
          Text('Measurements: ${measurements.join(', ')}'),
          Text('Flavors: ${flavors.join(', ')}'),
          const SizedBox(height: 16),
          // Form for setting prices
          const TextField(
            decoration: InputDecoration(labelText: 'Enter DP for Measurements'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration:
                InputDecoration(labelText: 'Enter SRP for Measurements'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(labelText: 'Enter DP for Flavors'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(labelText: 'Enter SRP for Flavors'),
            keyboardType: TextInputType.number,
          ),
        ],
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

  Future<void> _showInstructionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap "OK" to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Measurement Instructions'),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To Add Measurements:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                  '- In the "Add Measurement" section, type the first measurement in the text field.'),
              Text(
                  '- To add another measurement, continue typing in the last text field; a new one will be automatically created.'),
              Text(
                  '- To remove a measurement, simply erase the text in the corresponding text field.'),
              SizedBox(height: 16),
              Text(
                'Example:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- Type "Small" in the first text field.'),
              Text(
                  '- Continue typing "Medium" in the next field; a new field for "Large" will appear.'),
              Text('- Erase the text in the "Large" field to remove it.'),
              SizedBox(height: 8),
              Text(
                'Additional Notes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- Any number of measurement is allowed.'),
              Text('- It\'s okay to leave the last input field blank.'),
              Text(
                  '- You do not need to input values for all text fields; only fill in the ones with identified types or flavors.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTypeFlavorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap "OK" to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Type/Flavor Instructions'),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To Add Types/Flavors:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                  '- In the "Add Type/Flavor" section, type the first type or flavor in the text field.'),
              Text(
                  '- To add another type or flavor, continue typing in the last text field; a new one will be automatically created.'),
              Text(
                  '- To remove a type or flavor, simply erase the text in the corresponding text field.'),
              SizedBox(height: 16),
              Text(
                'Example:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- Type "Sweet" in the first text field.'),
              Text(
                  '- Continue typing another flavor "Salty" in the next field; a new field for "Spicy" will appear.'),
              Text('- Erase the text in the "Spicy" field to remove it.'),
              SizedBox(height: 16),
              Text(
                'Additional Notes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- Any number of types/flavors is allowed.'),
              Text(
                  '- It\'s okay to leave the last input field blank if not needed.'),
              Text(
                  '- You do not need to input values for all text fields; only fill in the ones with identified types or flavors.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
