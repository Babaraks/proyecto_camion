class Event {
  final int idEvent;
  final String nameEvent;
  final String status;
  final String date;
  final String startTime;
  final String endTime;

  Event({
    required this.idEvent,
    required this.nameEvent,
    required this.status,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idEvent: json['id_evento'],
      nameEvent: json['nombre_evento'],
      status: json['estado'],
      date: json['fecha'],
      startTime: json['hora_inicio'],
      endTime: json['hora_fin'],
    );
  }

    @override
  String toString() {
    return 'Event(ID: $idEvent, Name: $nameEvent, Status: $status, Date: $date, Start Time: $startTime, End Time: $endTime)';
  }
}


class Station {
  final int idStation;
  final String nameStation;
  final String coordinates;
  final String district;
  final Event? event;

  Station({
    required this.idStation,
    required this.nameStation,
    required this.coordinates,
    required this.district,
    this.event,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      idStation: json['id'],
      nameStation: json['nombre'],
      coordinates: json['coordenadas'],
      district: json['distrito'],
      event: json['evento'] != null ? Event.fromJson(json['evento']) : null,
    );
  }

    @override
  String toString() {
    return 'Station(ID: $idStation, Name: $nameStation, Coordinates: $coordinates, District: $district, Event: ${event?.toString() ?? 'No Event'})';
  }
}

class Routes {
  final int idRoute;
  final String nameRoute;
  final String vehicleType;
  final String? frecuency;
  final String firstRunTime;
  final String lastRunTime;
  final String color;
  final List<Station> stations;

  Routes({
    required this.idRoute,
    required this.nameRoute,
    required this.vehicleType,
    this.frecuency,
    required this.firstRunTime,
    required this.lastRunTime,
    required this.color,
    required this.stations,
  });

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      idRoute: json['ruta']['id'],
      nameRoute: json['ruta']['nombre'],
      vehicleType: json['ruta']['tipo_vehiculo'],
      frecuency: json['ruta']['frecuencia_paso'],
      firstRunTime: json['ruta']['primera_hora_corrida'],
      lastRunTime: json['ruta']['ultima_hora_corrida'],
      color: json['ruta']['color'],
      stations:
          (json['estaciones'] as List).map((e) => Station.fromJson(e)).toList(),
    );
  }

    @override
  String toString() {
    return 'Route(ID: $idRoute, Name: $nameRoute, Vehicle: $vehicleType, Frequency: $frecuency, First Run: $firstRunTime, Last Run: $lastRunTime, Color: $color, Stations: [${stations.join(', ')}])';
  }
}
