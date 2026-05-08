import 'package:flutter/material.dart';

class MainNews extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.asset('assets/Image1.png'),)
          ,
          const Text("Elon Musk Becomes The First Person worth \$700 billion following pay package ruling",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
        ],
      ),
    );

  }
}