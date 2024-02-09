// lib/reusable/chips.dart
import 'package:flutter/material.dart';

class ChoiceChipsWidget extends StatefulWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final String title;

  const ChoiceChipsWidget({super.key, 
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    required this.title,
  });

  @override
  _ChoiceChipsWidgetState createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          //chipgroup title
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D3F58),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          //generate chipgroup
          ...List.generate(
            widget.labels.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                checkmarkColor: const Color(0xFFEDF2F8),
                label: Text(widget.labels[index]),
                selected: widget.selectedIndex == index,
                onSelected: (bool selected) {
                  if (selected) {
                    setState(() {
                      widget.onSelected(index);
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
                elevation: 2,
                shadowColor: Colors.grey,
                side: BorderSide.none,
                backgroundColor: widget.selectedIndex == index
                    ? const Color(0xFF1D3F58)
                    : const Color(0xFFEEF3F9),
                selectedColor: const Color(0xFF1D3F58),
                labelStyle: TextStyle(
                  color: widget.selectedIndex == index ? const Color(0xFFEEF3F9) : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage Example
class ChoiceChips extends StatelessWidget {
  int selectedMeasurementIndex = 0;
  int selectedTypeIndex = 0;

  ChoiceChips({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceChipsWidget(
      labels: const ['155g', '95g', '180g', '45g'],
      selectedIndex: selectedMeasurementIndex,
      onSelected: (index) {
        // Handle chip selection
        // You can update your selectedMeasurementIndex or selectedTypeIndex here
      },
      title: 'Measurement:',
    );
  }
}
