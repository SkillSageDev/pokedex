import 'package:flutter/material.dart';
import 'navigation/AppRoutes.dart';
import 'navigation/RouterGenerator.dart';

void main() {
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget
{
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signup,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}