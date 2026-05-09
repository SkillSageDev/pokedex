import 'package:flutter/material.dart';
import 'package:pokedex/screens/home.dart';
import 'AppRoutes.dart';
import '../screens/home.dart';
import '../screens/favourite.dart';
import '../screens/signup.dart';
import '../screens/login.dart';
import '../screens/details.dart';

class RouterGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const Home());

      case AppRoutes.details:
      // 1. Receive the arguments as the Map sent from the Cards widget
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            builder: (_) => DetailScreen(
              heroTag: args["heroTag"],
              color: args["color"],
              pokemonDetail: args["pokemonDetail"],
            ),
          );
        }
        // Fallback if arguments are missing or wrong type
        return _errorRoute();

      case AppRoutes.favourite:
        return MaterialPageRoute(builder: (_) => const Favourite());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return _errorRoute();
    }
  }

  // Helper method to handle undefined routes or errors
  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(
          child: Text('Route not found or arguments are invalid'),
        ),
      ),
    );
  }
}