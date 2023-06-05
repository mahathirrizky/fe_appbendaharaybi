import 'dart:convert';

import '../constants/constants.dart';
import 'package:http/http.dart' as http;

class AuthApiClient {
  Future<String> login(String email, String password) async {
    final url = Uri.parse('$base_url/login');
    // Make API call to authenticate user
    // Implement your login logic here

    // Retrieve the token from the API response
    final response = await http.post(url,
        body: jsonEncode({"email": email, "password": password}));

    final responseData = json.decode(response.body);
    if (responseData['meta']['status'] == 'success') {
      return responseData['data']['token'];
    } else {
      throw Exception(responseData['meta']['message']);
    }
  }
}
