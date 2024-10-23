import 'package:flutter/material.dart';

class TravelStart extends StatelessWidget {
  TravelStart({super.key});

  final List<Map<String, dynamic>> _entries = [
    {
      "label": "Ekiti",
      "value": 0,
    },
    {
      "label": "Ibadan",
      "value": 0,
    },
    {
      "label": "Lagos",
      "value": 0,
    },
    {
      "label": "Abuja",
      "value": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownMenu(
            width: MediaQuery.sizeOf(context).width,
            hintText: "I'm leaving from...",
            dropdownMenuEntries: List.generate(
              _entries.length,
              (i) => DropdownMenuEntry(
                value: _entries[i]['value'],
                label: _entries[i]['label'],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownMenu(
            width: MediaQuery.sizeOf(context).width,
            hintText: "I'm going to...",
            dropdownMenuEntries: List.generate(
              _entries.length,
              (i) => DropdownMenuEntry(
                value: _entries[i]['value'],
                label: _entries[i]['label'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
