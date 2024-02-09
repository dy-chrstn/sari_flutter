import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

class RestockAddList extends StatefulWidget {
  const RestockAddList({super.key, required this.onChanged});

  final void Function(bool) onChanged;

  @override
  State<RestockAddList> createState() => _RestockAddListState();
  //_RestockAddListState createState() => _RestockAddListState();
}

class _RestockAddListState extends State<RestockAddList> {
  final List<String> size = ['95g', '125g', '155g', '180g', '420g'];
  final List<String> type = ['Flakes in Oil', 'Hot & Spicy', 'Corned Tuna'];
  int? _typeValue = 1;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart_sharp),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFB3CDE4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: ListView.builder(
            itemCount: 24,
            itemBuilder: (BuildContext context, int index) {
              return buildCard();
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SizedBox(
        height: 84,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Row(
              children: [
                Image.asset('lib/assets/century.png'),
                const SizedBox(width: 11),
                buildCardDetails(),
                const Spacer(),
                buildArrowButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardDetails() {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Century Tuna',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text('₱44.00'),
        ],
      ),
    );
  }

  Widget buildArrowButton() {
    return IconButton(
      icon: const Icon(Icons.keyboard_arrow_right_sharp),
      onPressed: () {
        showFlexibleBottomSheet(
          minHeight: 0,
          initHeight: 0.6,
          maxHeight: 0.7,
          context: context,
          builder: (
            BuildContext context,
            ScrollController scrollController,
            double bottomSheetOffset,
          ) {
            return Material(
              child: Container(
                height: double.maxFinite,
                color: const Color(0xFFB3CDE4),
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          buildProductInfo(),
                          const Text('Type'),
                          buildTypeChips(type),
                          const Text('Size'),
                          buildTypeChips(size),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildProductInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Century Tuna",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              Text("₱44.00", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            width: 75,
            child: Image.asset('lib/assets/century.png'),
          ),
        ),
      ],
    );
  }

  Widget buildTypeChips(List<String> myList) {
    return Wrap(
      spacing: 5.0,
      children: List<Widget>.generate(
        myList.length,
        (int index) {
          return ChoiceChip(
            label: Text(myList[index]),
            selected: _typeValue == index,
            onSelected: (bool selected) {
              setState(() {
                _typeValue = selected ? index : null;
              });
              widget.onChanged(selected);
            },
          );
        },
      ).toList(),
    );
  }
}
