import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'main.dart';
import 'restock_add_list.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:counter_button/counter_button.dart';

class RestockAdd extends StatefulWidget {
  const RestockAdd({super.key, required this.onChanged});

  final void Function(bool) onChanged;

  @override
  _RestockAddState createState() => _RestockAddState();
}

class _RestockAddState extends State<RestockAdd> {
  var logger = Logger();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  var _price = '0.00';
  var _valueSelected = 0.0;
  final double _quantityResult = 0.0;
  var _counterValue = 1;
  var _initialPrice = 0.0;
  var result;
  bool isChecked = false;
  final List<String> size = ['95g', '125g', '155g', '180g', '420g'];
  final List<String> type = ['Flakes in Oil', 'Hot & Spicy', 'Corned Tuna'];
  int? _typeValue = 1;
  int? _sizeValue = 1;
  ScrollController scrollController = ScrollController();

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
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '125g':
        setState(() {
          _valueSelected = 28.00;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '155g':
        setState(() {
          _valueSelected = 38.00;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '180g':
        setState(() {
          _valueSelected = 46.00;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      case '420g':
        setState(() {
          _valueSelected = 96.00;
          _price = _valueSelected.toStringAsFixed(2);
        });
        break;
      default:
        setState(() {
          _price = 0.00.toStringAsFixed(
              2); // Set a default value or handle other cases if needed
        });
    }

    Row generateProductRestock() {
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
              dropDownItemCount: 8,
              searchShowCursor: false,
              enableSearch: true,
              searchKeyboardType: TextInputType.text,
              dropDownList: const [
                DropDownValueModel(name: 'Century Tuna', value: "Century Tuna"),
                DropDownValueModel(name: 'LuckyMe', value: "LuckyMe"),
                DropDownValueModel(
                    name: 'Ligo Sardines', value: "Ligo Sardines"),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
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
                                        (int index) {
                                          return ChoiceChip(
                                            label: Text(type[index]),
                                            selected: _typeValue == index,
                                            selectedColor:
                                                const Color(0xFF1D3F58),
                                            labelStyle: TextStyle(
                                                color: _typeValue == index
                                                    ? Colors.white
                                                    : Colors.black),
                                            checkmarkColor: _typeValue == index
                                                ? Colors.white
                                                : Colors.black,
                                            onSelected: (bool selected) {
                                              setState(() {
                                                _typeValue =
                                                    selected ? index : null;
                                              });
                                              widget.onChanged(selected);
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    const Text('Size'),
                                    Wrap(
                                      spacing: 5.0,
                                      children: List<Widget>.generate(
                                        size.length,
                                        (int index) {
                                          return ChoiceChip(
                                            label: Text(size[index]),
                                            selected: _sizeValue == index,
                                            selectedColor:
                                                const Color(0xFF1D3F58),
                                            labelStyle: TextStyle(
                                                color: _sizeValue == index
                                                    ? Colors.white
                                                    : Colors.black),
                                            checkmarkColor: _sizeValue == index
                                                ? Colors.white
                                                : Colors.black,
                                            onSelected: (bool selected) {
                                              setState(() {
                                                _sizeValue =
                                                    selected ? index : null;
                                                if (selected) {
                                                  calculatePrice(size[index]);
                                                }
                                              });
                                              widget.onChanged(selected);
                                            },
                                          );
                                        },
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
                                                // _initialPrice = _counterValue.toDouble() * _valueSelected;
                                                // logger.d(_counterValue.toDouble());
                                                // logger.d(_valueSelected.toDouble());
                                                // logger.d(_initialPrice.toDouble());
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
            "₱$_initialPrice",
            // "₱$_valueSelected",
            style: const TextStyle(fontSize: 16),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Row(
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
                    dropDownItemCount: 8,
                    searchShowCursor: false,
                    enableSearch: true,
                    searchKeyboardType: TextInputType.text,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'Century Tuna', value: "Century Tuna"),
                      DropDownValueModel(name: 'LuckyMe', value: "LuckyMe"),
                      DropDownValueModel(
                          name: 'Ligo Sardines', value: "Ligo Sardines"),
                      DropDownValueModel(name: 'Milo', value: 'Milo'),
                      DropDownValueModel(name: 'Bearbrand', value: 'Bearbrand'),
                      DropDownValueModel(name: 'Kopiko', value: 'Kopiko'),
                      DropDownValueModel(
                          name: 'Great Taste', value: 'Great Taste'),
                      DropDownValueModel(name: 'Rice', value: 'Rice'),
                      DropDownValueModel(name: 'Soy Sauce', value: 'Soy Sauce'),
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
                      showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
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
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    //century tuna text
                                                    const Text(
                                                      "Century Tuna",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                              (int index) {
                                                return ChoiceChip(
                                                  label: Text(type[index]),
                                                  selected: _typeValue == index,
                                                  selectedColor:
                                                      const Color(0xFF1D3F58),
                                                  labelStyle: TextStyle(
                                                      color: _typeValue == index
                                                          ? Colors.white
                                                          : Colors.black),
                                                  checkmarkColor:
                                                      _typeValue == index
                                                          ? Colors.white
                                                          : Colors.black,
                                                  onSelected: (bool selected) {
                                                    setState(() {
                                                      _typeValue = selected
                                                          ? index
                                                          : null;
                                                    });
                                                    widget.onChanged(selected);
                                                  },
                                                );
                                              },
                                            ).toList(),
                                          ),
                                          const Text('Size'),
                                          Wrap(
                                            spacing: 5.0,
                                            children: List<Widget>.generate(
                                              size.length,
                                              (int index) {
                                                return ChoiceChip(
                                                  label: Text(size[index]),
                                                  selected: _sizeValue == index,
                                                  selectedColor:
                                                      const Color(0xFF1D3F58),
                                                  labelStyle: TextStyle(
                                                      color: _sizeValue == index
                                                          ? Colors.white
                                                          : Colors.black),
                                                  checkmarkColor:
                                                      _sizeValue == index
                                                          ? Colors.white
                                                          : Colors.black,
                                                  onSelected: (bool selected) {
                                                    setState(() {
                                                      _sizeValue = selected
                                                          ? index
                                                          : null;
                                                      if (selected) {
                                                        calculatePrice(
                                                            size[index]);
                                                      }
                                                    });
                                                    widget.onChanged(selected);
                                                  },
                                                );
                                              },
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
                                                countColor:
                                                    const Color(0xFF001B2E),
                                                buttonColor:
                                                    const Color(0xFF1D3F58),
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
                                                      // _initialPrice = _counterValue.toDouble() * _valueSelected;
                                                      // logger.d(_counterValue.toDouble());
                                                      // logger.d(_valueSelected.toDouble());
                                                      // logger.d(_initialPrice.toDouble());
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF001B2E),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                  "₱$_initialPrice",
                  // "₱$_valueSelected",
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: (Material(
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Ink(
                          decoration: const ShapeDecoration(
                              color: Color(0xFF001B2E), shape: CircleBorder()),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {});
                              // Add your onPressed logic here
                            },
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
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
