import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // We pass the data directly here so it loads immediately on run
    home: DetailScreen(
      heroTag: "bulbasaur",
      color: Colors.teal,
      pokemonDetail: {
        "name": "Bulbasaur",
        "num": "001",
        "type": ["Grass", "Poison"],
        "height": "0.7 m",
        "weight": "6.9 kg",
        "img": "assets/images/bulbasaur.png", // Ensure this path is in pubspec.yaml
      },
    ),
  ));
}

class DetailScreen extends StatefulWidget {
  final String heroTag;
  final Map pokemonDetail;
  final Color color;

  // Constructor with required parameters
  DetailScreen({
    required this.heroTag,
    required this.pokemonDetail,
    required this.color,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // Fixed height for the green header area
    var topPanelHeight = height * 0.35;

    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Background Decoration
          Positioned(
            top: 40,
            right: -50,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                'assets/images/pokeball_white.png',
                height: 250,
                width: 250,
                fit: BoxFit.contain,
                // Fallback icon if the asset isn't found yet
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, size: 200, color: Colors.white10),
              ),
            ),
          ),

          // 2. Back Button (Note: Navigator.pop won't do anything if this is the only screen)
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ),

          // 3. Header Info
          Positioned(
            top: 100,
            left: 25,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.pokemonDetail['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "#" + widget.pokemonDetail['num'],
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: (widget.pokemonDetail['type'] as List).map((t) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white24,
                      ),
                      child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 16)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // 4. White Data Card
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height - topPanelHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 80, left: 25, right: 25),
                child: Column(
                  children: [
                    _buildStatRow("Height", widget.pokemonDetail['height']),
                    _buildStatRow("Weight", widget.pokemonDetail['weight']),
                    _buildStatRow("Abilities", "Overgrow"),
                    const SizedBox(height: 20),
                    Text(
                      "All data is passed directly through the main() function. "
                          "Make sure your images are added to pubspec.yaml and the project folders.",
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Main Image
          Positioned(
            top: topPanelHeight - 130,
            child: Hero(
              tag: widget.heroTag,
              child: Image.asset(
                widget.pokemonDetail['img'],
                height: 240,
                width: 240,
                fit: BoxFit.contain,
                // This shows a placeholder if you haven't put the image in assets yet
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              child: Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
          ),
          Text(value, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}