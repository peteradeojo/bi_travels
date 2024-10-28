import "dart:convert";

import "package:http/http.dart" as http;

// Run location search
Future<List<dynamic>> runLocationSearch(String query) async {
  try {
    final response = await http.get(Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&countrycode=ng"));

    if (response.statusCode == 200) return jsonDecode(response.body);

    return [];
  } catch (e) {
    print(e.toString());
    return [];
  }
}
