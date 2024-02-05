import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchDataFromServer() async {
  final response = await http.get(Uri.parse('http://mongodb://localhost:27017/your_api_route'));

  if (response.statusCode == 200) {
    // Parse and handle the data here mongodb://localhost:27017
    final data = json.decode(response.body);
    print(data);
  } else {
    // Handle error
    print('Error: ${response.statusCode}');
  }
}
