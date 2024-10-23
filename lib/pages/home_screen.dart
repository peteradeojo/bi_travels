import 'package:bi_travels/pages/bi_extensions.dart';
import 'package:bi_travels/pages/delivery_start.dart';
import 'package:bi_travels/pages/travel_start.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _screens = [
    const BiExtension(),
    const DeliveryStart(),
    TravelStart(),
    const Scaffold(),
  ];

  final List<dynamic> _scaffolds = [
    {
      "title": "Bi Extensions",
      "backgroundColor": Colors.red,
      "foregroundColor": Colors.white,
    },
    {
      "title": "Send Package",
      "leading": true,
    },
    {
      "title": "Travel",
      "leading": true,
    },
    {
      "title": "History",
      "leading": true,
      "backgroundColor": Colors.red,
      "foregroundColor": Colors.white,
    },
  ];

  _appBars(context) => List.generate(_scaffolds.length, (int i) {
        return AppBar(
          title: Text(
            _scaffolds[i]["title"],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: _scaffolds[i]["backgroundColor"],
          foregroundColor: _scaffolds[i]["foregroundColor"],
          leading: _scaffolds[i]["leading"] != true
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex -= 1;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
        );
      });

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars(context)[_currentIndex],
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.red,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.motorcycle), label: 'Delivery'),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_bus), label: 'Travel'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      ),
    );
  }
}
