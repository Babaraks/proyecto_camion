import 'package:flutter/material.dart';
import '../data/services/route_service.dart';
import '../models/route_model.dart';

class RouteViewModel extends ChangeNotifier {
  final RouteService _service = RouteService();
  List<Routes> _routes = [];
  bool _isLoading = false;

  List<Routes> get routes => _routes;
  bool get isLoading => _isLoading;

  Future<void> fetchRoutes() async {
    if (_routes.isNotEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      _routes = await _service.fetchRoutes();
      routes.forEach((route) {
        print(route);
      });
    } catch (e) {
      throw Exception('Error al cargar las rutas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
