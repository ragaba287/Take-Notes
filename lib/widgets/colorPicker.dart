import 'package:flutter/material.dart';

class MyColorPicker extends StatefulWidget {
  final Function onSelectColor;
  final List<Color> availableColors; // List of pickable colors
  final Color initialColor;

  MyColorPicker({
    @required this.onSelectColor,
    @required this.availableColors,
    @required this.initialColor,
  });

  @override
  _MyColorPickerState createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  // This variable used to determine where the checkmark will be
  Color _pickedColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 40,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.availableColors.length,
        itemBuilder: (context, index) {
          final itemColor = widget.availableColors[index];
          return InkWell(
            onTap: () {
              widget.onSelectColor(itemColor);
              setState(() {
                _pickedColor = itemColor;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: itemColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.5, color: Colors.black)),
              child: itemColor == _pickedColor
                  ? Center(
                      child: Icon(Icons.check,
                          color: itemColor == Colors.black
                              ? Colors.white
                              : Colors.black),
                    )
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
