import 'package:flutter/material.dart';

class Sort extends StatefulWidget
{
  const Sort({super.key});

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort>
{
  List sort = ["Home", "Business", "Politics", "Sports"];
  String choosed = "Home";

  @override
  Widget build(BuildContext context)
  {
    return Wrap(
      spacing: 8.0,
      children: sort.map((name)
      {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (choosed == name) ? Colors.red : Colors.white,
            foregroundColor: (choosed == name) ? Colors.white : Colors.black,
          ),
          onPressed: () {
            setState(() {
              choosed = name;
            });
          },
          child: Text(name),
        );
      }).toList(),
    );
  }
}