import 'package:appli/customs/models/data.dart';
import 'package:flutter/material.dart';

import '../customs/colors/custom_colors.dart';
import '../customs/utilities/constants.dart';

class EntregarItem extends StatefulWidget {
  const EntregarItem({Key? key, required this.item, required this.max})
      : super(key: key);

  final ItemEstoque item;
  final int max;

  @override
  State<EntregarItem> createState() => _EntregarItemState();
}

class _EntregarItemState extends State<EntregarItem> {
  int quantidade = 0;

  bool get minValue => quantidade == 0;
  bool get maxValue => quantidade == widget.max;

  void decreaseValue() => quantidade--;
  void addValue() => quantidade++;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: pDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.item.item),
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(
                      () => minValue ? null : decreaseValue(),
                    ),
                    icon: Icon(
                      Icons.remove,
                      color: minValue
                          ? CustomColors.lightOrange
                          : CustomColors.orange,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Center(child: Text('$quantidade')),
                  ),
                  IconButton(
                    onPressed: () => setState(
                      () => maxValue ? null : addValue(),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: maxValue
                          ? CustomColors.lightOrange
                          : CustomColors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
