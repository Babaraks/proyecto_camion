class Route {
  final int idRoute;
  final String nameRoute;
  final String firstDepartureTime;
  final String lastDepartureTime;
  final String vehicleType;
  final String passingFrecuency;
  final String vehicleColor;

  Route({
    required this.idRoute,
    required this.nameRoute,
    required this.firstDepartureTime,
    required this.lastDepartureTime,
    required this.vehicleType,
    required this.passingFrecuency,
    required this.vehicleColor
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      idRoute: json['id_route'],
      nameRoute: json['name_route'],
      firstDepartureTime: json['first_departure_time'],
      lastDepartureTime: json['last_departure_time'],
      vehicleType: json['type_vehicle'],
      passingFrecuency: json['passing_frecuency'],
      vehicleColor: json['type_color'],
    );
  }

}