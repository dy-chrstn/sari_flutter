import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ProductDetails(),
  ));
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  int selectedMeasurementIndex = 0;
  int selectedTypeIndex = 0;

  Widget buildChoiceChips(
    List<String> labels,
    int selectedIndex,
    ValueChanged<int> onSelected,
    String title,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...[
            const SizedBox(
              width: 16,
            ),
            //chipgroup title
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D3F58)),
            ),
            const SizedBox(
              width: 16,
            ),
            //generate chipgroup
            ...List.generate(
              labels.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  checkmarkColor: const Color(0xFFEDF2F8),
                  label: Text(labels[index]),
                  selected: selectedIndex == index,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        onSelected(index);
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  elevation: 2,
                  shadowColor: Colors.grey,
                  side: BorderSide.none,
                  backgroundColor:
                      selectedIndex == index ? const Color(0xFF1D3F58) : const Color(0xFFEEF3F9),
                  selectedColor: const Color(0xFF1D3F58),
                  labelStyle: TextStyle(
                    color: selectedIndex == index ? const Color(0xFFEEF3F9) : null,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Add your edit button functionality here
                },
                icon: const Icon(Icons.edit,
                color: Color(0xFF1D3F58),),
              ),
              IconButton(
                onPressed: () {
                  // Add your delete button functionality here
                },
                icon: const Icon(Icons.delete,
                color: Color(0xFF1D3F58),),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFB3CDE4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            SizedBox(
              height: 275,
              child: Image.asset(
                'lib/assets/century.png', // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),

            // Measurement Choices
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: buildChoiceChips(
                ['155g', '95g', '180g', '45g'],
                selectedMeasurementIndex,
                (int index) {
                  setState(() {
                    selectedMeasurementIndex = index;
                  });
                  // Add logic for changing price based on measurement
                },
                'Measurement:',
              ),
            ),

            // Type/Flavor Choices
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: buildChoiceChips(
                ['Flakes in Oil', 'Hot & Spicy'],
                selectedTypeIndex,
                (int index) {
                  setState(() {
                    selectedTypeIndex = index;
                  });
                  // Add logic for changing price based on type
                },
                'Type:',
              ),
            ),

            // Card for product details
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Product Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(width: 0),
                        ),
                        Text(
                          '₱49.00',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFC80D0D)),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          '6419950082624',
                          style: TextStyle(color: Color(0xFF537692)),
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 0,
                        )),
                        Text(
                          '₱44.00',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF537692)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Canned Goods',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Stocks: 12',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 64),

                    
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D3F58),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          )
                        ),
                        child: const Icon(Icons.add,
                        color: Color(0xFFEEF3F9),)),
                        const SizedBox(width: 10,),
                        ElevatedButton(onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          )
                        ),
                        child: const Icon(Icons.remove,
                        color: Color(0xFF1D3F58),))

                      ],
                    )
                  
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
