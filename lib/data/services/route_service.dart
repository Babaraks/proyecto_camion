import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_movil/data/auth/auth.dart';
import '../../models/route_model.dart';

class RouteService {
  final endpoint = 'https://apirutas.onrender.com/get_view_full_route_stop_event_info';
  final AuthToken authToken = AuthToken();

  Future<List<Routes>> fetchRoutes() async {
    // String? token = await authToken.fetchToken();
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> responseJson = jsonDecode(response.body);
      
      return responseJson.map((item) => Routes.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar las rutas: ${response.statusCode}');
    }
  }

}