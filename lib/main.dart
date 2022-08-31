import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/src/utils/navigation_utils.dart';
import 'package:shopping/src/utils/route_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: routeHome,
      onGenerateRoute: NavigationUtils.generateRoute,
    );
  }
}
