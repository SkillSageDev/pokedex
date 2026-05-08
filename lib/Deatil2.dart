import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DetailScreen(
      heroTag: "bulbasaur",
      color: Colors.teal,
      pokemonDetail: {
        "name": "Bulbasaur",
        "num": "001",
        "type": ["Grass", "Poison"],
        "img": "assets/images/bulbasaur.png",
        "description": "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.",
        "height": "0.7 m",
        "weight": "6.9 kg",
        "species": "Seed Pokemon",
        "ability": "Overgrow",
        "stats": {
          "HP": 45,
          "Attack": 49,
          "Defense": 49,
          "Sp. Atk": 65,
          "Sp. Def": 65,
          "Speed": 45,
        }
      },
    ),
  ));
}

class DetailScreen extends StatefulWidget {
  final String heroTag;
  final Map pokemonDetail;
  final Color color;

  DetailScreen({
    required this.heroTag,
    required this.pokemonDetail,
    required this.color,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // CHANGED: Length is now 2
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, size: 200, color: Colors.white10),
              ),
            ),
          ),

          // 2. Back Button
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.maybePop(context),
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
                    Text(widget.pokemonDetail['name'], style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                    Text("#${widget.pokemonDetail['num']}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: (widget.pokemonDetail['type'] as List).map((t) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white24),
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    // CHANGED: Only 2 Tabs here
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: widget.color,
                      labelPadding: EdgeInsets.zero,
                      tabs: const [
                        Tab(text: "About"),
                        Tab(text: "Base Stats"),
                      ],
                    ),
                    // CHANGED: Only 2 Children here
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildAboutTab(),
                          _buildStatsTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Main Hero Image
          Positioned(
            top: topPanelHeight - 140,
            child: Hero(
              tag: widget.heroTag,
              child: Image.asset(
                widget.pokemonDetail['img'],
                height: 200,
                width: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB BUILDERS ---

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.pokemonDetail['description'], style: const TextStyle(height: 1.5, fontSize: 15)),
          const SizedBox(height: 25),
          _buildInfoRow("Species", widget.pokemonDetail['species']),
          _buildInfoRow("Height", widget.pokemonDetail['height']),
          _buildInfoRow("Weight", widget.pokemonDetail['weight']),
          _buildInfoRow("Abilities", widget.pokemonDetail['ability']),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    Map stats = widget.pokemonDetail['stats'];
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: stats.keys.map((key) {
          double progress = stats[key] / 100.0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                SizedBox(width: 80, child: Text(key, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
                SizedBox(width: 40, child: Text(stats[key].toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: progress > 0.5 ? Colors.green : Colors.red,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
          Text(value, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}