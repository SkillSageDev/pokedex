import 'package:flutter/material.dart';
import 'home/sort.dart';
import 'home/cards.dart';
import '../navigation/AppRoutes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
// Renamed from _NewsPostState to _HomeState
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          const Sort(activeTab: "Home"),
          Expanded(
            child: Cards(),
          ),
        ],
      ),
    );
  }
}