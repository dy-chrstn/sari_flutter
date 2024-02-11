import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'main.dart';
import 'restock_add_list.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:counter_button/counter_button.dart';

class RestockAdd extends StatefulWidget {
  List<double> initialPriceList = [];
  final void Function(bool) onChanged;

  RestockAdd({
    super.key,
    required this.initialPriceList,
    required this.onChanged,
  });

  @override
  _RestockAddState createState() => _RestockAddState();
}

class _RestockAddState extends State<RestockAdd> {
  // Variables
  double totalPrice = 0.0;
  final Map<int, int> _rowQuantities = {}; // Key: row index, Value: quantity
  var logger = Logger();

  var result;
  bool isChecked = false;
  String selectedValue = "Default Option";
  final int _typeValue = 1;

// Lists
  List<String> itemList = ["Item 1"];
  final List<String> size = ['95g', '125g', '155g', '180g', '420g'];
  final List<String> type = ['Flakes in Oil', 'Hot & Spicy', 'Corned Tuna'];
  List<double> selectedValues = [];
  double total = 0.0;
  List<double> initialPrices = [0.0];

  // void _updatePriceInList(int index, double newPrice) {
  //   setState(() {
  //     widget.initialPriceList[index] = newPrice;
  //     Logger().d(newPrice);
  //     // double totalPrice = widget.initialPriceList.sum();

  //     // _totalPrice = totalPrice; // Store the total price for display
  //     for (double price in widget.initialPriceList) {
  //       totalPrice += price;
  //     }
  //   });
  // }

  void _updatePriceInList(double index, double newPrice) {
    setState(() {
      // Access _quantity of the corresponding RowWidget based on index
      Logger().d("index: $index, newPrice: $newPrice");
      // double quantity = _rowQuantities[index] as double; // Assuming _rowQuantities is set up

      // Update price in initialPriceList based on new price and quantity
      widget.initialPriceList[index.toInt()] = newPrice;

      // Recalculate total price if needed
      // double totalPrice = widget.initialPriceList.sum();
      // _totalPrice = totalPrice; // Store the total price for display
      // Or iterate and update totalPrice as you previously suggested
      totalPrice = 0;

      for (double price in widget.initialPriceList) {
        totalPrice += price;

        Logger().d("totalPrice: $totalPrice");
      }

      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  //generate row
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.initialPriceList.length,
                    itemBuilder: (BuildContext context, index) {
                      return RowWidget(
                        initialPrice: widget.initialPriceList[index],
                        index: index,
                        updatePrice: _updatePriceInList, 
                        onChanged: (bool value) {
                          // Handle other changes in MyBody, if needed
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Text(
                        'TOTAL: ${totalPrice.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 110,
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: 10,
              )
            ],
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {});
            widget.initialPriceList.add(widget.initialPriceList.length + 1);
          },
          backgroundColor: const Color(0xFF1D3F58),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class RowWidget extends StatefulWidget {
  // final double initialPrice;
  // final int index;
  // final Function(int, double) updatePrice;
  // final void Function(bool) onChanged;

  // const RowWidget({
  //   super.key,
  //   required this.initialPrice,
  //   required this.index,
  //   required this.updatePrice,
  //   required this.onChanged,
  // });

  final double initialPrice;
  final int index;
  final void Function(double, double) updatePrice; 
  final void Function(bool) onChanged;

  const RowWidget({
    super.key,
    required this.initialPrice,
    required this.index,
    required this.updatePrice,
    required this.onChanged,
  });

  @override
  _RowWidgetState createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  bool isChecked = false;
  String selectedValue = "Default Option";
  // Focus Nodes
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  // Scroll Controller
  ScrollController scrollController = ScrollController();
  // Variables
  var logger = Logger();
  var _price = '0.00';
  var _valueSelected = 0.0;
  var _counterValue = 1;
  var _initialPrice = 0.0;
  var result;
  int? _typeValue = 1;
  int _sizeValue = 1;
  double _currentPrice = 0.0;
  double quantity = 1;
  final double _quantity = 1; // Initialize with a default quantity

// Lists
  List<String> itemList = ["Item 1"];
  final List<String> size = ['95g', '125g', '155g', '180g', '420g'];
  final List<String> type = ['Flakes in Oil', 'Hot & Spicy', 'Corned Tuna'];

  @override
  void initState() {
    super.initState();
    // _currentPrice = widget.initialPrice; // Initialize with initial price
    _sizeValue = 0; // Set initial selected index (adjust if different)
    calculatePrice(size[_sizeValue]); // Call with initially selected size
    _initialPrice = quantity * _valueSelected;
    // _initialPrice = _quantity * widget.initialPrice;
  }

  void mutiplyQuantity(double quantity) {
    setState(() {
      _initialPrice = quantity * _valueSelected;
    });
  }

  void calculatePrice(String selectedSize) {
    switch (selectedSize) {
      case '95g':
        setState(() {
          _valueSelected = 23.00;
          _initialPrice = _valueSelected;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '125g':
        setState(() {
          _valueSelected = 28.00;
          _initialPrice = _valueSelected;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '155g':
        setState(() {
          _valueSelected = 38.00;
          _initialPrice = _valueSelected;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '180g':
        setState(() {
          _valueSelected = 46.00;
          _initialPrice = _valueSelected;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '420g':
        setState(() {
          _valueSelected = 96.00;
          _initialPrice = _valueSelected;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      default:
        setState(() {
          _price = 0.00.toStringAsFixed(
              2); // Set a default value or handle other cases if needed
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //checkbox
        checkbox(),
        SizedBox(
          width: 250,
          child: DropDownTextField(
            clearOption: false,
            dropDownIconProperty: IconProperty(size: 0.0),
            textFieldFocusNode: textFieldFocusNode,
            searchFocusNode: searchFocusNode,
            textFieldDecoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Input Product',
            ),
            // searchAutofocus: true,
            dropDownItemCount: 5,
            searchShowCursor: true,
            enableSearch: true,
            searchKeyboardType: TextInputType.text,
            dropDownList: const [
              DropDownValueModel(name: 'Century Tuna', value: "Century Tuna"),
              DropDownValueModel(name: 'LuckyMe', value: "LuckyMe"),
              DropDownValueModel(name: 'Ligo Sardines', value: "Ligo Sardines"),
              DropDownValueModel(name: 'Milo', value: 'Milo'),
              DropDownValueModel(name: 'Bearbrand', value: 'Bearbrand'),
              DropDownValueModel(name: 'Kopiko', value: 'Kopiko'),
              DropDownValueModel(name: 'Great Taste', value: 'Great Taste'),
              DropDownValueModel(name: 'Rice', value: 'Rice'),
              DropDownValueModel(name: 'Soy Sauce', value: 'Soy Sauce'),
              DropDownValueModel(name: 'Vinegar', value: 'Vinegar'),
              DropDownValueModel(name: 'Corned Beef', value: 'Corned Beef'),
              DropDownValueModel(name: 'Meatloaf', value: 'Meatloaf'),
              DropDownValueModel(name: 'Joy', value: 'Joy'),
              DropDownValueModel(name: 'Surf', value: 'Surf'),
              DropDownValueModel(name: 'Breeze', value: 'Breeze'),
              DropDownValueModel(name: 'Wings', value: 'Wings'),
              DropDownValueModel(name: 'Ariel', value: 'Ariel'),
              DropDownValueModel(name: 'Tide', value: 'Tide'),
              DropDownValueModel(name: 'Downy', value: 'Downy'),
              DropDownValueModel(name: 'Zonrox', value: 'Zonrox'),
            ],
            onChanged: (val) {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Material(
                      child: Container(
                        color: const Color(0xFFB3CDE4),
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //century tuna text
                                            const Text(
                                              "Century Tuna",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            Text("₱$_price",
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      //century tuna image
                                      Expanded(
                                        child: SizedBox(
                                          height: 100,
                                          width: 75,
                                          child: Image.asset(
                                              'lib/assets/century.png'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text('Type'),
                                  Wrap(
                                    spacing: 5.0,
                                    children: List<Widget>.generate(
                                      type.length,
                                      (int typeIndex) => ChoiceChip(
                                        label: Text(type[typeIndex]),
                                        selected: _typeValue == typeIndex,
                                        selectedColor: const Color(0xFF1D3F58),
                                        labelStyle: TextStyle(
                                          color: _typeValue == typeIndex
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        checkmarkColor: _typeValue == typeIndex
                                            ? Colors.white
                                            : Colors.black,
                                        onSelected: (bool selected) {
                                          // Ensure selection even if deselected
                                          _typeValue = selected
                                              ? typeIndex
                                              : _typeValue ?? 0;

                                          // Update all chip visuals based on current selection
                                          setState(() {
                                            // No need to explicitly set other chips to unselected,
                                            // as _typeValue change handles that implicitly.
                                          });
                                          widget.onChanged(selected);
                                        },
                                      ),
                                    ).toList(),
                                  ),
                                  const Text('Size'),
                                  Wrap(
                                    spacing: 5.0,
                                    children: List<Widget>.generate(
                                      size.length,
                                      (int sizeIndex) => ChoiceChip(
                                        label: Text(size[sizeIndex]),
                                        selected: _sizeValue == sizeIndex,
                                        selectedColor: const Color(0xFF1D3F58),
                                        labelStyle: TextStyle(
                                          color: _sizeValue == sizeIndex
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        checkmarkColor: _sizeValue == sizeIndex
                                            ? Colors.white
                                            : Colors.black,
                                        onSelected: (bool selected) {
                                          // Ensure selection even if deselected
                                          _sizeValue = selected
                                              ? sizeIndex
                                              : _sizeValue;

                                          // Update all chip visuals based on current selection
                                          setState(() {
                                            _counterValue = 1;
                                            _sizeValue =
                                                selected ? sizeIndex : sizeIndex;
                                            if (selected) {
                                              calculatePrice(size[sizeIndex]);
                                            }
                                          });
                                          widget.onChanged(selected);
                                        },
                                      ),
                                    ).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Container(
                                      color: Colors.white,
                                      child: CounterButton(
                                        loading: false,
                                        onChange: (int val) {
                                          setState(() {
                                            _counterValue = val;
                                            // _initialPrice = _counterValue.toDouble() * _valueSelected;
                                            mutiplyQuantity(
                                                _counterValue.toDouble());
                                          });
                                        },
                                        count: _counterValue,
                                        countColor: const Color(0xFF001B2E),
                                        buttonColor: const Color(0xFF1D3F58),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              // _handlePriceChange(_initialPrice);
                                              widget.updatePrice(widget.index.toDouble(), _initialPrice);
                                              Logger().d("Widget.index: ${widget.index}, initialPrice: $_initialPrice");
                                              // widget.updatePrice(widget.index.toDouble(), _initialPrice);
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF001B2E),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                          child: const Text("CONFIRM",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
          ),
        ),
        Text(
          "₱$_initialPrice"
          '0',
          // "₱$_valueSelected",
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget checkbox() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return const Color(0xFF1D3F58);
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
