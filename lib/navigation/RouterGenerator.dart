//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/item.dart';
import 'AppRoutes.dart';
import '../screens/details.dart';
import '../screens/news_post.dart';
import '../screens/favourite.dart';
import '../screens/signup.dart';
import '../screens/login.dart';

class RouterGenerator {

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => NewsPost()); //=> Route
      case AppRoutes.details:
       final args = settings.arguments as Item;
       return MaterialPageRoute(builder: (_) => DetailsScreen(item: args));
      case AppRoutes.favourite:
        return MaterialPageRoute(builder: (_) => Favourite());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
       default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }

}