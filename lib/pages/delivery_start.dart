import 'dart:convert';

import 'package:bi_travels/components/text_input.dart';
import 'package:bi_travels/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class DeliveryStart extends StatefulWidget {
  const DeliveryStart({super.key});

  @override
  State<DeliveryStart> createState() => _DeliveryStartState();
}

class _DeliveryStartState extends State<DeliveryStart> {
  debounce(Function f, {Duration duration = Durations.long2}) {
    DateTime t = DateTime.now();

    return (dynamic a) {
      if (DateTime.now().difference(t) < (duration)) {
        return;
      }

      f(a);
      t = DateTime.now();
    };
  }

  List<dynamic> _locations = [];

  bool _showSelectLocationOption = false;
  bool _displaySearchResults = false;
  bool _displayToSearchResults = false;
  bool _chooseToLocationOnMap = false;

  final _fromTextController = TextEditingController(),
      _toTextController = TextEditingController();

  Map<String, dynamic>? _fromLocation, _toLocation;

  _selectLocation() {
    setState(() {
      _showSelectLocationOption = _fromTextController.text.isEmpty;
      _chooseToLocationOnMap = false;
    });
  }

  Future<void> _searchLocation(String value) async {
    if (value.isEmpty) {
      setState(() {
        _showSelectLocationOption = true;
      });

      // return;
    }

    if (_showSelectLocationOption) {
      setState(() {
        _showSelectLocationOption = false;
      });
    }

    if (!_displaySearchResults) {
      setState(() {
        _displaySearchResults = true;
        _displayToSearchResults = false;
      });
    }

    final response = await http.get(
      Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$value&format=json&countrycode=ng",
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        _locations = jsonDecode(response.body);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    final response = await http.get(Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?lat=${pos.latitude}&lon=${pos.longitude}&format=json"));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _fromTextController.text = jsonResponse["display_name"];
      setState(() {
        _showSelectLocationOption = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextInput(
                      hintText: "From",
                      controller: _fromTextController,
                      onTap: _selectLocation,
                      onChanged: debounce(_searchLocation),
                    ),
                    // Search results display
                    ConstrainedBox(
                      // width: MediaQuery.sizeOf(context).width,
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                      ),
                      // color: Colors.grey.shade200,
                      child: _displaySearchResults
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (c, i) {
                                return ListTile(
                                  title: Text(_locations[i]["display_name"]),
                                  focusColor: Colors.red.shade200,
                                  selectedColor: Colors.red.shade200,
                                  onTap: () {
                                    _fromTextController.text =
                                        _locations[i]["display_name"];
                                    setState(() {
                                      _fromLocation = _locations[i];
                                      _displaySearchResults = false;
                                      _showSelectLocationOption = false;
                                    });
                                  },
                                );
                              },
                              itemCount: _locations.length,
                            )
                          : null,
                    ),
                    Container(
                      child: _showSelectLocationOption
                          ? MaterialButton(
                              color: Colors.blue.shade800,
                              textColor: Colors.white,
                              onPressed: _getCurrentLocation,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on),
                                  Text("USE YOUR LOCATION"),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 16,
                            color: Colors.grey.shade600,
                            weight: 0.5,
                          ),
                          Icon(
                            Icons.more_vert,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          Icon(
                            Icons.arrow_downward,
                            size: 16,
                            color: Colors.grey.shade600,
                            weight: 0.5,
                          ),
                        ],
                      ),
                    ),
                    TextInput(
                      hintText: "To",
                      onTap: () {
                        setState(() {
                          _chooseToLocationOnMap =
                              _toTextController.text.isEmpty;
                          _displaySearchResults = false;
                          _showSelectLocationOption = false;
                        });
                      },
                      onChanged: debounce((String a) async {
                        setState(() {
                          _chooseToLocationOnMap = false;
                          _displaySearchResults = false;
                        });

                        var locations = await runLocationSearch(a);
                        setState(() {
                          _locations = locations;
                          _displayToSearchResults = true;
                        });
                      }),
                      controller: _toTextController,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 200,
                      ),
                      child: _chooseToLocationOnMap
                          ? MaterialButton(
                              color: Colors.blue.shade800,
                              textColor: Colors.white,
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.map_outlined),
                                  Text("CHOOSE LOCATION ON MAP"),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                      child: _displayToSearchResults
                          ? ListView.builder(
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title: Text(_locations[i]["display_name"]),
                                  focusColor: Colors.red.shade200,
                                  selectedColor: Colors.red.shade200,
                                  onTap: () {
                                    _toTextController.text =
                                        _locations[i]["display_name"];
                                    setState(() {
                                      _toLocation = _locations[i];
                                      _displayToSearchResults = false;
                                      _chooseToLocationOnMap = false;
                                    });
                                  },
                                );
                              },
                              shrinkWrap: true,
                              itemCount: _locations.length,
                            )
                          : null,
                    )
                  ],
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  minWidth: MediaQuery.sizeOf(context).width,
                  height: 40,
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
