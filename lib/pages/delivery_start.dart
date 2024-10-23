import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryStart extends StatefulWidget {
  const DeliveryStart({super.key});

  @override
  State<DeliveryStart> createState() => _DeliveryStartState();
}

class _DeliveryStartState extends State<DeliveryStart> {
  final bool _wantsPickup = false;
  bool _showSelectLocationOption = false;

  final _fromTextController = TextEditingController();

  _selectLocation() {
    if (_fromTextController.text.isEmpty) {
      print("_tapped to select from");
      setState(() {
        _showSelectLocationOption = true;
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

    _fromTextController.text = "${pos.longitude},${pos.latitude}";
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
                    TextField(
                      // autofocus: true,
                      controller: _fromTextController,
                      onTap: _selectLocation,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _showSelectLocationOption = false;
                          });
                        } else {
                          setState(() {
                            _showSelectLocationOption = true;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(gapPadding: 4),
                        hintText: "From",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                      ),
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
                    // const SizedBox(
                    //   height: 40,
                    // ),
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
                    TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(gapPadding: 4),
                        hintText: "To",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Row(
                    //       children: [
                    //         Text(
                    //           "Pick-up and Dropoff",
                    //         ),
                    //         Icon(
                    //           Icons.question_mark,
                    //           size: 18,
                    //           color: Colors.red,
                    //         ),
                    //       ],
                    //     ),
                    //     Switch(
                    //       value: _wantsPickup,
                    //       onChanged: (i) {
                    //         setState(() {
                    //           _wantsPickup = i;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // )
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
