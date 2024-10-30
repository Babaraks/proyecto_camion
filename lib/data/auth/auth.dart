import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  final String endpoint = '';

  Future<String?> fetchToken() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data[''];

      final payload = _decodeJwt(token);
      final expirationDate = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

      await _saveToken(token, expirationDate);
      return token;
    } else {
      throw Exception('Error al obtener el token.');
    }
  }

  Future<void> _saveToken(String token, DateTime expirationDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('token_expiration', expirationDate.toIso8601String());
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final expirationDateStr = prefs.getString('token_expiration');

    if (token != null && expirationDateStr != null) {
      final expirationDate = DateTime.parse(expirationDateStr);
      if (DateTime.now().isBefore(expirationDate)) {
        return token;
      } else {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length !=3) {
      throw Exception('El JWT no es valido.');
    }
    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return jsonDecode(payload);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('token_expiration');
  }

}