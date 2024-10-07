import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';

class InterestWidget extends StatefulWidget {
  const InterestWidget({super.key});

  @override
  State<InterestWidget> createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  final List<ColorItem> allItemList = [
    ColorItem('Red', Colors.red),
    ColorItem('Green', Colors.green),
    ColorItem('Blue', Colors.blue),
    ColorItem('Yellow', Colors.yellow),
    ColorItem('Black', Colors.black),
    ColorItem('Violet', Colors.purple),
  ];

  List<ColorItem> selectedVerticalItems = [];
  List<ColorItem> selectedHorizontalItems = [];
  List<ColorItem> selectedWrapItems = [];

  @override
  void initState() {
    super.initState();
    selectedVerticalItems = [allItemList[2], allItemList[3]];
    selectedHorizontalItems = [allItemList[3], allItemList[4]];
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F4F9),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'We\'ll recommend great topics based on the topics you select',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 1200,
                    height: 600,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: <Widget>[
                        buildCheckboxSection(
                            'VERTICAL ORIENTATION EXAMPLE',
                            CheckboxOrientation.vertical,
                            selectedVerticalItems,
                            updateVerticalItems,
                            [allItemList[0]]),
                        Divider(height: 2.0),
                        buildCheckboxSection(
                            'HORIZONTAL ORIENTATION EXAMPLE',
                            CheckboxOrientation.horizontal,
                            selectedHorizontalItems,
                            updateHorizontalItems,
                            [allItemList[1]]),
                        Divider(height: 2.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          margin: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          child: buildCheckboxSection(
                              'WRAP ORIENTATION EXAMPLE',
                              CheckboxOrientation.wrap,
                              selectedWrapItems,
                              updateWrapItems,
                              [allItemList[2]]),
                        ),
                        SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

void updateVerticalItems(List<ColorItem> newItems) {
  // setState(() {
  //   selectedVerticalItems = newItems;
  // });
}

void updateHorizontalItems(List<ColorItem> newItems) {
  // setState(() {
  //   selectedHorizontalItems = newItems;
  // });
}

void updateWrapItems(List<ColorItem> newItems) {
  // setState(() {
  //   selectedWrapItems = newItems;
  // });
}

Widget buildCheckboxSection(
    String title,
    CheckboxOrientation orientation,
    List<ColorItem> selectedItems,
    Function(List<ColorItem>) updateFunction,
    List<ColorItem> disabledItems) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.blue, fontSize: 15.0),
        ),
        // GroupedCheckbox<ColorItem>(
        //   itemList: allItemList,
        //   checkedItemList: selectedItems,
        //   disabled: disabledItems,
        //   onChanged: (itemList) {
        //     updateFunction(itemList!);
        //   },
        //   orientation: orientation,
        //   checkColor: Colors.purpleAccent,
        //   activeColor: Colors.lightBlue,
        //   itemWidgetBuilder: (item) => Text(
        //     item.name,
        //     style: TextStyle(color: item.color),
        //   ),
        // ),
        SizedBox(height: 5.0),
        Text(
          'Selected Colors: ${selectedItems.map((item) => item.name).join(', ')}',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    ),
  );
}

class ColorItem {
  String name;
  Color color;

  ColorItem(this.name, this.color);
}
