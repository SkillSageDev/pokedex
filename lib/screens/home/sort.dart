import 'package:flutter/material.dart';
import '../../navigation/app_routes.dart';

class Sort extends StatefulWidget {
  final String activeTab;
  const Sort({super.key, this.activeTab = "Home"});

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  final List<String> sortOptions = ["Home", "Favorites"];
  late String choosed;

  @override
  void initState() {
    super.initState();
    choosed = widget.activeTab;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: sortOptions.map((name) {
        bool isSelected = (choosed == name);

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.red : Colors.white,
            foregroundColor: isSelected ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
            // Inside your Sort widget's onPressed:
            onPressed: () {
              if (isSelected) return;

              if (name == "Favorites") {
                // Navigator.pushReplacementNamed ensures the screen is fresh
                Navigator.pushReplacementNamed(context, AppRoutes.favourite);
              } else if (name == "Home") {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
          child: Text(name),
        );
      }).toList(),
    );
  }
}