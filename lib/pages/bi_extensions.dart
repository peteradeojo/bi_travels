import 'package:bi_travels/components/home_slider.dart';
import 'package:flutter/material.dart';

class BiExtension extends StatelessWidget {
  const BiExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HomeSlider(),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My packages",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You haven't delivered any packages yet. Start delivering packages to track them here.",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
