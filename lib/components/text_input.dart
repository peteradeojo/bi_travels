import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TapRegionCallback? onTapOutside;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final String hintText;

  const TextInput(
      {super.key,
      this.controller,
      this.onChanged,
      this.onTap,
      this.onTapOutside,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      onTapOutside: onTapOutside,
      child: TextField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(gapPadding: 4),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
          )),
    );
  }
}
