import 'package:flutter/material.dart';

import '../model/item.dart';

class DetailsScreen extends StatelessWidget {
  final Item item;
  const DetailsScreen({super.key , required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Details"),
      ),



      body: SafeArea(
        child: Column(
          children: [
            Text(item.title , style: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),),

            const SizedBox(height: 20,),

            Image.asset(item.imagePath,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20,),
            Text(
              "Dec 20 (Reuters) - Tesla (TSLA.O) & Owner Of (X) Decided To Buy A Special Flower That Costs Him Around \$20 Million Dollar Making His Wealth From \$825 Billion Dollar To  \$824,980,000,000 Billion Dollar, Making Him The 2nd Place From The Richest Person In The Planet Making Mohammed Elkayar Having a Wealth Of \$824,980,000,001 , For That Elon Must Stated And Said \"I't Was A Goregous Flower",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
