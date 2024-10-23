import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  final double padding = 12.0;
  final String text;
  final IconData icon;

  const SliderItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: Colors.red, //.shade400,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});
  final double padding = 12.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselView(
        itemExtent: MediaQuery.sizeOf(context).width - 64,
        itemSnapping: true,
        shrinkExtent: MediaQuery.sizeOf(context).width - 128,
        shape: const BeveledRectangleBorder(),
        children: const [
          SliderItem(
              text: "Send packages easily, anywhere in Nigeria.",
              icon: Icons.motorcycle),
          SliderItem(
              text: "Book long-distance luxury rides, anywhere in Nigeria.",
              icon: Icons.directions_bus),
          SliderItem(
              text: "Find affordable accomodation that fits your needs.",
              icon: Icons.apartment),
        ],
      ),
    );
  }
}
