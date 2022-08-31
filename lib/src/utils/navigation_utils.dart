import 'package:flutter/material.dart';
import 'package:shopping/src/ui/cart_screen.dart';
import 'package:shopping/src/ui/products_screen.dart';
import 'package:shopping/src/utils/route_constant.dart';

class NavigationUtils {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    var args = settings!.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => ProductScreen());
      case routeCart:
        return MaterialPageRoute(builder: (_) => CartScreen());

      default:
        return _errorRoute("Coming soon...");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  static void popUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).popUntil(
      ModalRoute.withName(routeName),
    );
  }

  static String? getRouteName(BuildContext context) {
    print("route name===${ModalRoute.of(context)!.settings.name}");
    return ModalRoute.of(context)!.settings.name;
  }
}
