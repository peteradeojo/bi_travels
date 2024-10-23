import 'package:bi_travels/pages/bi_extensions.dart';
import 'package:bi_travels/pages/delivery_start.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int index;

  const BottomNav({super.key, required this.index});

  List<Widget> navItems(context) => [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BiExtension(),
              ),
            );
          },
          icon: Icon(
            Icons.home_rounded,
            color: index == 0 ? Colors.red : Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeliveryStart(),
              ),
            );
          },
          icon: Icon(
            Icons.motorcycle,
            color: index == 1 ? Colors.red : Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.history,
            color: index == 2 ? Colors.red : Colors.black,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems(context),
      ),
    );
  }
}
