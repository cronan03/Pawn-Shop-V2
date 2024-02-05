import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addUserDataToServer(Map<String, dynamic> userData) async {
  final String serverUrl = 'http://localhost:3000/adduser'; // Replace with your actual server address and route

  try {
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      print('User data added successfully');
    } else {
      print('Failed to add user data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error adding user data: $error');
  }
}
