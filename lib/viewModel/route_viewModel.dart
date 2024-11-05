import 'package:flutter/material.dart';
import '../data/services/route_service.dart';
import '../models/route_model.dart';

class RouteViewModel extends ChangeNotifier {
  final RouteService _service = RouteService();
  List<Routes> _routes = [];
  bool _isLoading = false;

  List<Routes> get routes => _routes;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> get stations {
    return routes.map((route) {
      return {
        'route': route.nameRoute,
        'stations':  route.stations.map((station) {
          return {
            'station': station.nameStation,
            'coordinates': station.coordinates,
          };
        }).toList(),
      };
    }).toList();
  }

  Future<void> fetchRoutes() async {
    if (_routes.isNotEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      _routes = await _service.fetchRoutes();
      stations.forEach((station) {
        print('\n');
        print(station);
        print('\n');
      });
    } catch (e) {
      throw Exception('Error al cargar las rutas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
