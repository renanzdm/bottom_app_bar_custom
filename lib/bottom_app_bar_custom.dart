import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {this.items,
      this.onTap,
      this.backgroundColor,
      this.selectedColor,
      this.unselectedColor,
      this.iconColorSelected,
      this.iconColorUnselected});

  final List<ItemModel> items;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color iconColorSelected;
  final Color iconColorUnselected;
  final Function(int) onTap;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTap(index);
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildTabItem(
      {int index, ItemModel itemModel, ValueChanged<int> onPressed}) {
    return Container(
      alignment: Alignment.center,
      //color: Colors.green,
      width: 50,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.bounceOut,
            bottom: selectedIndex == index ? 4 : 0,
            child: InkWell(
              onTap: () {
                onPressed(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? widget.selectedColor
                          : widget.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    height: selectedIndex == index ? 35 :30,
                    width:  selectedIndex == index ? 35 :30,
                    child: Icon(
                      itemModel.icon,
                      color: selectedIndex == index
                          ? widget.iconColorSelected
                          : widget.iconColorUnselected,
                      size: selectedIndex == index ? 30 : 25,
                    ),
                  ),
                  Text(
                    itemModel.label,
                    style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.grey[700]
                            : widget.iconColorUnselected,
                        fontSize: selectedIndex == index ? 18 : 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = List.generate(widget.items.length, (index) {
      return _buildTabItem(
        itemModel: widget.items[index],
        index: index,
        onPressed: (index) {
          _updateIndex(index);
        },
      );
    });
    return Container(
      decoration: BoxDecoration(color: widget.backgroundColor, boxShadow: [
        BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, -2.0),
            blurRadius: 10,
            spreadRadius: 2),
      ]),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      ),
    );
  }
}

class ItemModel {
  final IconData icon;
  final String label;

  ItemModel({
    this.icon,
    this.label,
  });
}
