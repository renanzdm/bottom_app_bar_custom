import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({this.items, this.onTap});
  final List<ItemModel> items;

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
    double bottom = selectedIndex == index ? 10 : 0;
    return Container(
      alignment: Alignment.center,
      //color: Colors.green,
      width: 50,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: bottom,
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
                      border:
                          Border.fromBorderSide(BorderSide(color: Colors.red)),
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    height: 30,
                    width: 30,
                    child: Icon(itemModel.icon),
                  ),
                  Text(itemModel.label),
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
      height: 50,
      color: Colors.red,
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
