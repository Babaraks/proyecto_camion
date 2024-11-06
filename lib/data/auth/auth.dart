import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  final endpoint = 'https://apirutas.onrender.com/generate_jwt';

  Future<String?> fetchToken() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['jwt'];

      await _saveToken(token);
      return token;
    } else {
      throw Exception('Error al obtener el token.');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}