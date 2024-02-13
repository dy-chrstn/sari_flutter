import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  var logger = Logger();

  bool isChecked = false;
  String selectedValue = "Default Option";

// Lists
  List<String> itemList = ["Item 1"];
  final List<String> size = ['95g', '125g', '155g', '180g', '420g'];
  final List<String> type = ['Flakes in Oil', 'Hot & Spicy', 'Corned Tuna'];
  List<double> selectedValues = [];
  double total = 0.0;
  List<double> initialPrices = [0.0];

  void _updatePriceInList(double index, double newPrice) {
    setState(() {
      // Update price in initialPriceList based on new price and quantity
      widget.initialPriceList[index.toInt()] = newPrice;

      totalPrice = 0;

      for (double price in widget.initialPriceList) {
        totalPrice += price;

        // Logger().d("Price: $price");
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
                  const TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Title",
                      hintStyle:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      focusColor: Colors.blue,
                    ),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                        'TOTAL: ₱${totalPrice.toString()}' '0',
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
            setState(() {
              // _updatePriceInList(index.toDouble(), 0.00);
            });
            // widget.initialPriceList.add(0);
            widget.initialPriceList.add(0);
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
  bool isChecked = false, toMinimize = false;
  // Focus Nodes
  FocusNode searchFocusNode = FocusNode(), textFieldFocusNode = FocusNode();
  // Scroll Controller
  ScrollController scrollController = ScrollController();
  // Variables
  String toConcat = '', finalConcat = '';
  var logger = Logger(), selectedValue = "Default Item";
  var _initialPrice = 0.0, _valueSelected = 0.0, _price = '0.00';
  int _defaultValue = 1;
  int? _typeValue, _sizeValue;
  late int typeIndex = 0, sizeIndex = 0, _counterValue = 1;
  double quantity = 1;
  List<String> itemList = ["Item 1"];
  final List<String> size = ['95g', '125g', '155g', '180g', '420g'];
  final List<String> type = ['Flakes in Oil', 'Hot & Spicy', 'Corned Tuna'];
  final List<String> defaultChip = ['Default'];

  @override
  void initState() {
    super.initState();
    calculatePrice(defaultChip[0]);
    _initialPrice = quantity * _valueSelected;
    // _initialPrice = _quantity * widget.initialPrice;
    // toMinimize = false;
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
      // case 'Default':
      //   setState(() {
      //     _valueSelected = 0.00;
      //     _initialPrice = _valueSelected;
      //     _price = _valueSelected.toStringAsFixed(2);
      //   });
      //   break;
      default:
        setState(() {
          _valueSelected = 0.0;
          _initialPrice = _valueSelected;
          _price = _valueSelected.toStringAsFixed(2);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: isChecked
              ? const Color.fromARGB(255, 128, 171, 202)
              : Colors.transparent,
          child: Row(
            children: [
              //checkbox
              checkbox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: toMinimize ? 30 : 50,
                    width: 200,
                    child: DropDownTextField(
                      initialValue: selectedValue,
                      clearOption: false,
                      dropDownIconProperty: IconProperty(size: 0.0),
                      textFieldFocusNode: textFieldFocusNode,
                      searchFocusNode: searchFocusNode,
                      textFieldDecoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Default Item',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        suffixStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      // searchAutofocus: true,
                      dropDownItemCount: 5,
                      searchShowCursor: true,
                      enableSearch: true,
                      searchKeyboardType: TextInputType.text,
                      dropDownList: const [
                        DropDownValueModel(
                            name: 'Default Item', value: "Default Item"),
                        DropDownValueModel(
                            name: 'Century Tuna', value: "Century Tuna"),
                        DropDownValueModel(name: 'LuckyMe', value: "LuckyMe"),
                        DropDownValueModel(
                            name: 'Ligo Sardines', value: "Ligo Sardines"),
                        DropDownValueModel(name: 'Milo', value: 'Milo'),
                        DropDownValueModel(
                            name: 'Bearbrand', value: 'Bearbrand'),
                        DropDownValueModel(name: 'Kopiko', value: 'Kopiko'),
                        DropDownValueModel(
                            name: 'Great Taste', value: 'Great Taste'),
                        DropDownValueModel(name: 'Rice', value: 'Rice'),
                        DropDownValueModel(
                            name: 'Soy Sauce', value: 'Soy Sauce'),
                        DropDownValueModel(name: 'Vinegar', value: 'Vinegar'),
                        DropDownValueModel(
                            name: 'Corned Beef', value: 'Corned Beef'),
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
                        toMinimize = false;

                        setState(() {
                          var toCompare = const DropDownValueModel(
                              name: 'Default Item', value: 'Default Item');
                          toMinimize = true;

                          if (val == toCompare) {
                            showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Material(
                                    child: Container(
                                      color: const Color(0xFFB3CDE4),
                                      child: ListView(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 24),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          //century tuna text
                                                          Text(
                                                            "Name",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18),
                                                          ),
                                                          Text("₱0.00",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                    ),
                                                    //century tuna image
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 100,
                                                        width: 75,
                                                        child: Image.asset(
                                                            'lib/assets/default_image.png'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Text('Type'),
                                                Wrap(
                                                  spacing: 5.0,
                                                  children:
                                                      List<Widget>.generate(
                                                    defaultChip.length,
                                                    (int defaultIndex) =>
                                                        ChoiceChip(
                                                      label: Text(defaultChip[
                                                          defaultIndex]),
                                                      selected: _defaultValue ==
                                                          defaultIndex,
                                                      selectedColor:
                                                          const Color(
                                                              0xFF1D3F58),
                                                      labelStyle: TextStyle(
                                                        color: _defaultValue ==
                                                                defaultIndex
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      checkmarkColor:
                                                          _defaultValue ==
                                                                  defaultIndex
                                                              ? Colors.white
                                                              : Colors.black,
                                                      onSelected:
                                                          (bool selected) {
                                                        // Ensure selection even if deselected
                                                        _defaultValue = selected
                                                            ? defaultIndex
                                                            : _defaultValue;

                                                        // Update all chip visuals based on current selection
                                                        setState(() {
                                                          // No need to explicitly set other chips to unselected,
                                                          // as _typeValue change handles that implicitly.
                                                        });
                                                        widget.onChanged(
                                                            selected);
                                                      },
                                                    ),
                                                  ).toList(),
                                                ),
                                                const Text('Size'),
                                                Wrap(
                                                  spacing: 5.0,
                                                  children:
                                                      List<Widget>.generate(
                                                    defaultChip.length,
                                                    (int defaultIndex) =>
                                                        ChoiceChip(
                                                      label: Text(defaultChip[
                                                          defaultIndex]),
                                                      selected: _defaultValue ==
                                                          defaultIndex,
                                                      selectedColor:
                                                          const Color(
                                                              0xFF1D3F58),
                                                      labelStyle: TextStyle(
                                                        color: _defaultValue ==
                                                                defaultIndex
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      checkmarkColor:
                                                          _defaultValue ==
                                                                  defaultIndex
                                                              ? Colors.white
                                                              : Colors.black,
                                                      onSelected:
                                                          (bool selected) {
                                                        // Ensure selection even if deselected
                                                        _defaultValue = selected
                                                            ? defaultIndex
                                                            : _defaultValue;

                                                        // Update all chip visuals based on current selection
                                                        setState(() {
                                                          _counterValue = 1;
                                                          _defaultValue =
                                                              selected
                                                                  ? defaultIndex
                                                                  : defaultIndex;
                                                          if (selected) {
                                                            calculatePrice(
                                                                defaultChip[
                                                                    defaultIndex]);
                                                          }
                                                        });
                                                        widget.onChanged(
                                                            selected);
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
                                                              _counterValue
                                                                  .toDouble());
                                                        });
                                                      },
                                                      count: _counterValue,
                                                      countColor: const Color(
                                                          0xFF001B2E),
                                                      buttonColor: const Color(
                                                          0xFF1D3F58),
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
                                                            widget.updatePrice(
                                                                widget.index
                                                                    .toDouble(),
                                                                _initialPrice);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF001B2E),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                        child: const Text(
                                                            "CONFIRM",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
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
                          } else {
                            showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Material(
                                    child: Container(
                                      color: const Color(0xFFB3CDE4),
                                      child: ListView(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 24),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          //century tuna text
                                                          const Text(
                                                            "Century Tuna",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18),
                                                          ),
                                                          Text("₱$_price",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16)),
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
                                                  children:
                                                      List<Widget>.generate(
                                                    type.length,
                                                    (typeIndex) => ChoiceChip(
                                                      label:
                                                          Text(type[typeIndex]),
                                                      selected: _typeValue ==
                                                          typeIndex,
                                                      selectedColor:
                                                          const Color(
                                                              0xFF1D3F58),
                                                      labelStyle: TextStyle(
                                                        color: _typeValue ==
                                                                typeIndex
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      checkmarkColor:
                                                          _typeValue ==
                                                                  typeIndex
                                                              ? Colors.white
                                                              : Colors.black,
                                                      onSelected:
                                                          (bool selected) {
                                                        // Ensure selection even if deselected
                                                        _typeValue = selected
                                                            ? typeIndex
                                                            : _typeValue ?? 0;

                                                        // Update all chip visuals based on current selection
                                                        setState(() {
                                                          Logger().d(
                                                              type[typeIndex]);
                                                          // No need to explicitly set other chips to unselected,
                                                          // as _typeValue change handles that implicitly.
                                                        });
                                                        widget.onChanged(
                                                            selected);
                                                      },
                                                    ),
                                                  ).toList(),
                                                ),
                                                const Text('Size'),
                                                Wrap(
                                                  spacing: 5.0,
                                                  children:
                                                      List<Widget>.generate(
                                                    size.length,
                                                    (sizeIndex) => ChoiceChip(
                                                      label:
                                                          Text(size[sizeIndex]),
                                                      selected: _sizeValue ==
                                                          sizeIndex,
                                                      selectedColor:
                                                          const Color(
                                                              0xFF1D3F58),
                                                      labelStyle: TextStyle(
                                                        color: _sizeValue ==
                                                                sizeIndex
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      checkmarkColor:
                                                          _sizeValue ==
                                                                  sizeIndex
                                                              ? Colors.white
                                                              : Colors.black,
                                                      onSelected:
                                                          (bool selected) {
                                                        // Ensure selection even if deselected
                                                        _sizeValue = selected
                                                            ? sizeIndex
                                                            : _sizeValue;

                                                        // Update all chip visuals based on current selection
                                                        setState(() {
                                                          _counterValue = 1;
                                                          _sizeValue = selected
                                                              ? sizeIndex
                                                              : sizeIndex;
                                                          if (selected) {
                                                            calculatePrice(size[
                                                                sizeIndex]);
                                                          }
                                                        });
                                                        widget.onChanged(
                                                            selected);
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
                                                              _counterValue
                                                                  .toDouble());
                                                        });
                                                      },
                                                      count: _counterValue,
                                                      countColor: const Color(
                                                          0xFF001B2E),
                                                      buttonColor: const Color(
                                                          0xFF1D3F58),
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
                                                            widget.updatePrice(
                                                                widget.index
                                                                    .toDouble(),
                                                                _initialPrice);

                                                            finalConcat =
                                                                "${type[_typeValue!.toInt()]}, ${size[_sizeValue!.toInt()]} - ${_counterValue}pcs";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF001B2E),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                        child: const Text(
                                                            "CONFIRM",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
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
                          }
                        });
                      },
                    ),
                  ),
                  // ${type[_typeValue!.toInt()]}, ${size[_sizeValue!.toInt()]} - ${_counterValue}pcs";
                  SizedBox(
                    height: toMinimize ? 25 : 0,
                    child: Text(
                      finalConcat,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    // child: RichText(
                    //   text:  TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: "${type[_typeValue!.toInt()]} ,",
                    //         style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
                    //       ),
                    //       TextSpan(
                    //         text: "18",
                    //         style: TextStyle(fontSize: 10, color: Colors.black87),
                    //       ),
                    //       TextSpan(
                    //         text: " normal", style: TextStyle(color: Colors.black87),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  )
                ],
              ),
              const Spacer(),
              Text(
                "₱$_initialPrice"
                '0',
                // "₱$_valueSelected",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
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
