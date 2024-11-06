import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiYmFiYXJha3MiLCJhIjoiY20yd2d5bGF0MDZrdDJtb2gxcTNxdjgyeSJ9.zUK9kwqn5lJkvq0t1cbVkA';

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  LatLng? myois;

  List<LatLng> Line_1 = [
    LatLng(20.607164143393103, -103.40099060932518),
    LatLng(20.613852803078487, -103.39557630586775),
    LatLng(20.621903228131234, -103.38919445652147),
    LatLng(20.626941433162838, -103.38496293871493),
    LatLng(20.63314219983959, -103.38041049446396),
    LatLng(20.647398106434355, -103.3691319220742),
    LatLng(20.643092836679234, -103.37261295570225),
    LatLng(20.6483, -103.3524),
    LatLng(20.65456862973601, -103.36373941610283),
    LatLng(20.661234010031286, -103.35751502256672),
    LatLng(20.66681476168441, -103.35529006982368),
    LatLng(20.675022232269317, -103.3547702359691),
    LatLng(20.682181469428595, -103.35363931642071),
    LatLng(20.69176871634982, -103.35405893868315),
    LatLng(20.699625826767928, -103.35475393856188),
    LatLng(20.708087933042766, -103.35550838894267),
    LatLng(20.720949839183483, -103.35335337302722),
    LatLng(20.72088329848796, -103.35329712478618),
    LatLng(20.730687860034923, -103.35228647307798),
    LatLng(20.736015505261047, -103.35043878282531),
  ];

  List<LatLng> Line_2 = [
    LatLng(20.660030644094284, -103.27600470140936),
    LatLng(20.662465921797033, -103.28572165998136),
    LatLng(20.663928155670337, -103.2973940060203),
    LatLng(20.665303962292047, -103.30609975212366),
    LatLng(20.66757756775042, -103.31336347349102),
    LatLng(20.670269298898038, -103.32277725739901),
    LatLng(20.672721946816505, -103.33137808742399),
    LatLng(20.6755006814347, -103.34082108369456),
    LatLng(20.67524527355783, -103.34807600646103),
    LatLng(20.674604563134597, -103.35467840796677),
    LatLng(20.741138773527375, -103.4073163357648),
    LatLng(20.738112427230757, -103.40313552651658),
    LatLng(20.72907909182224, -103.38907773942518),
    LatLng(20.720613088141494, -103.38698283572582),
    LatLng(20.712267899332527, -103.37499572335173),
    LatLng(20.70643699933144, -103.36592596059356),
    LatLng(20.699426336900682, -103.35435374823221),
    LatLng(20.692854486424526, -103.3483353352683),
    LatLng(20.684134455352453, -103.34791819830896),
    LatLng(20.67576431103955, -103.34736637316091),
    LatLng(20.671173662404918, -103.34473749552582),
    LatLng(20.665030201203066, -103.3326353686291),
    LatLng(20.659860265952442, -103.32411196715088),
    LatLng(20.651004673232695, -103.3100792290876),
    LatLng(20.64482002470734, -103.30401018290281),
    LatLng(20.6378107766273, -103.29996675281029),
    LatLng(20.632927329826686, -103.29646918703612),
    LatLng(20.623251449713926, -103.28533909807935),
  ];

  List<LatLng> Line_3 = [
    LatLng(20.741138773527375, -103.4073163357648),
    LatLng(20.738112427230757, -103.40313552651658),
    LatLng(20.72907909182224, -103.38907773942518),
    LatLng(20.720613088141494, -103.38698283572582),
    LatLng(20.712267899332527, -103.37499572335173),
    LatLng(20.70643699933144, -103.36592596059356),
    LatLng(20.699426336900682, -103.35435374823221),
    LatLng(20.692854486424526, -103.3483353352683),
    LatLng(20.684134455352453, -103.34791819830896),
    LatLng(20.67576431103955, -103.34736637316091),
    LatLng(20.671173662404918, -103.34473749552582),
    LatLng(20.665030201203066, -103.3326353686291),
    LatLng(20.659860265952442, -103.32411196715088),
    LatLng(20.651004673232695, -103.3100792290876),
    LatLng(20.64482002470734, -103.30401018290281),
    LatLng(20.6378107766273, -103.29996675281029),
    LatLng(20.632927329826686, -103.29646918703612),
    LatLng(20.623251449713926, -103.28533909807935),
  ];

  List<LatLng> routeCoordinates = [];

  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Error al obtener permisos de ubicación');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myois = LatLng(position.latitude, position.longitude);
      print(myois);
      fetchRoutes();
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> fetchRoutes() async {
    List<Polyline> polylines = [];

    List<List<LatLng>> allLines = [Line_1, Line_2, Line_3];

    for (var line in allLines) {
      List<LatLng> lineCoordinates = [];

      for (int i = 0; i < line.length - 1; i++) {
        final start = line[i];
        final end = line[i + 1];
        final coordinates = await fetchRoute(start, end);
        if (coordinates != null) {
          lineCoordinates.addAll(coordinates);
        }
      }

      if (lineCoordinates.isNotEmpty) {
        polylines.add(Polyline(
          points: lineCoordinates,
          strokeWidth: 4.0,
          color: getColorForLine(line),
        ));
      }
    }

    setState(() {
      routePolylines = polylines;
    });
  }

  Color getColorForLine(List<LatLng> line) {
    if (line == Line_1) {
      return Colors.orange;
    } else if (line == Line_2) {
      return Colors.green;
    } else if (line == Line_3) {
      return Colors.blue;
    }
    return Colors.black;
  }

  List<Polyline> routePolylines = [];

  Future<List<LatLng>?> fetchRoute(LatLng start, LatLng end) async {
    final url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson&access_token=$MAPBOX_ACCESS_TOKEN';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coordinates = data['routes'][0]['geometry']['coordinates'] as List;
      return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
    } else {
      throw Exception('Error al obtener la ruta: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar ubicación',
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              // Acción cuando el usuario busca (ejemplo: actualizar el mapa con una nueva ubicación)
            },
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: myois == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: myois!,
                minZoom: 5,
                maxZoom: 25,
                initialZoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                  additionalOptions: const {
                    'accessToken': MAPBOX_ACCESS_TOKEN,
                    'id': 'mapbox/streets-v12',
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: myois!,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    ),
                    ...Line_1.map((point) {
                      return Marker(
                        width: 80.0,
                        height: 80.0,
                        point: point,
                        child: Icon(
                          Icons.circle,
                          color: Colors.orange,
                          size: 40.0,
                        ),
                      );
                    }).toList(),
                    ...Line_2.map((point) {
                      return Marker(
                        width: 80.0,
                        height: 80.0,
                        point: point,
                        child: Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 40.0,
                        ),
                      );
                    }).toList(),
                    ...Line_3.map((point) {
                      return Marker(
                        width: 80.0,
                        height: 80.0,
                        point: point,
                        child: Icon(
                          Icons.circle,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      );
                    }).toList(),
                  ],
                ),
                PolylineLayer(
                  polylines: routePolylines,
                ),
              ],
            ),
    );
  }
}
