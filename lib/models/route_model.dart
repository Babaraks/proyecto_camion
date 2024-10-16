class Route {
  final int idRoute;
  final String nameRoute;
  final String firstDepartureTime;
  final String lastDepartureTime;
  final String vehicleType;
  final String passingFrecuency;
  final String vehicleColor;
  final List<Stop> stops;

  Route({
    required this.idRoute,
    required this.nameRoute,
    required this.firstDepartureTime,
    required this.lastDepartureTime,
    required this.vehicleType,
    required this.passingFrecuency,
    required this.vehicleColor,
    required this.stops,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    var stopsFromJson = json['stops'] as List;
    List<Stop> stopList = stopsFromJson.map((i) => Stop.fromJson(i)).toList();

    return Route(
      idRoute: json['id_route'],
      nameRoute: json['name_route'],
      firstDepartureTime: json['first_departure_time'],
      lastDepartureTime: json['last_departure_time'],
      vehicleType: json['type_vehicle'],
      passingFrecuency: json['passing_frecuency'],
      vehicleColor: json['type_color'],
      stops: stopList,
    );
  }
}

class Stop {
  final int idStop;
  final String nameStop;
  final String locationCoordinates;
  final String district;
  final int? idEvent;
  final String? eventName;
  final String? eventDate;
  final String? startTimeEvent;
  final String? endTimeEvent;
  final String? eventStatus;
  final int? followUp;

  Stop({
    required this.idStop,
    required this.nameStop,
    required this.locationCoordinates,
    required this.district,
    this.idEvent,
    this.eventName,
    this.eventDate,
    this.startTimeEvent,
    this.endTimeEvent,
    this.eventStatus,
    this.followUp,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      idStop: json['id_stop'],
      nameStop: json['name_stop'],
      locationCoordinates: json['location_coordinates0'],
      district: json['district'],
      idEvent: json['id_event'],
      eventName: json['event_name'],
      eventDate: json['event_date'],
      startTimeEvent: json['start_time_event'],
      endTimeEvent: json['end_time_event'],
      eventStatus: json['event_status'],
      followUp: json['follow_up']
    );
  }

}

