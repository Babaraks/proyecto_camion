import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewModel/route_viewModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteViewModel()),
      ],
      child: MaterialApp(
        title: 'Route App',
        home: RouteScreen(),
      ),
    );
  }
}

class RouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeViewModel = Provider.of<RouteViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Routes')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await routeViewModel.fetchRoutes();
          },
          child: Text('Cargar Rutas'),
        ),
      ),
    );
  }
}
