import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DunksPage extends StatefulWidget {
  const DunksPage({super.key});

  @override
  State<DunksPage> createState() => _JordanPageState();
}

class _JordanPageState extends State<DunksPage> {
  List<String> sneakerimages = [
    // "https://images.vegnonveg.com/media/collections/101/17198391211016682a991ee9b7.png",
    "https://images.vegnonveg.com/resized/400X328/5358/nike-dunk-low-retro-whiteblack-white-60e41a479d3e7.jpg",
    "https://images.vegnonveg.com/resized/400X328/5363/w-nike-dunk-low-whiteblack-white-60e41b4c68977.jpg",
    "https://images.vegnonveg.com/resized/400X328/8828/nike-dunk-low-retro-whitegrey-fog-63ce764079383.jpg",
    "https://images.vegnonveg.com/resized/400X328/8828/nike-dunk-low-retro-whitegrey-fog-63ce764031209.jpg",
    "https://images.vegnonveg.com/resized/400X328/10539/dunk-low-dark-currywhite-white-658e94dce57fc.jpg",
    "https://images.vegnonveg.com/resized/400X328/11342/dunk-low-nn-summit-whitekhaki-baroque-brown-phantom-white-6690cf8f03a69.jpg",
    "https://images.vegnonveg.com/resized/400X328/11434/dunk-low-nn-baroque-brownblack-white-sail-brown-66bb4b2dc3a2a.jpg",
    "https://images.vegnonveg.com/resized/400X328/11407/dunk-low-blackmidnight-navy-white-university-red-white-66bb4bbad6fab.jpg",
    "https://images.vegnonveg.com/resized/400X328/11396/dunk-low-retro-whitedenim-turq-white-66b3660dc7ed0.jpg",
    "https://images.vegnonveg.com/resized/400X328/11406/dunk-low-coconut-milkflax-sail-brown-66b497326da01.jpg",
    "https://images.vegnonveg.com/resized/400X328/11408/dunk-low-game-royalblack-white-multicolor-66b4784782d8e.jpg",
    "https://images.vegnonveg.com/resized/400X328/11397/dunk-low-retro-whitedragon-red-black-white-66b3667e7b69f.jpg"
  ];
  List<String> sneakername = [ "JORDAN JUMPMAN SLIDE NEUTRAL GREY/METALLIC SILVER",
    "DUNK LOW RETRO 'WHITE/BLACK'",
    "DUNK LOW 'WHITE/BLACK' Womens",
    "DUNK LOW RETRO 'WHITE/GREY FOG'",
    "DUNK LOW 'DARK CURRY/WHITE'",
    "DUNK LOW NN 'SUMMIT WHITE/KHAKI-BAROQUE BROWN-PHANTOM'",
    "DUNK LOW NN 'BAROQUE BROWN/BLACK-WHITE-SAIL'",
    "DUNK LOW 'BLACK/MIDNIGHT NAVY-WHITE-UNIVERSITY RED'",
    "DUNK LOW RETRO 'WHITE/DENIM TURQ'",
    "DUNK LOW 'COCONUT MILK/FLAX-SAIL'",
    "DUNK LOW 'GAME ROYAL/BLACK-WHITE'",
    "DUNK LOW RETRO 'WHITE/DRAGON RED-BLACK'",
    "DUNK LOW NN 'PHANTOM/OBSIDIAN-PALE IVORY'"];
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredSneakerImages = [];
  List<String> _filteredSneakerNames = [];
  @override
  void initState() {
    super.initState();
    _filteredSneakerImages = sneakerimages;
    _filteredSneakerNames = sneakername;
    _searchController.addListener(_filterSneakers);
  }

  void _filterSneakers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSneakerImages = sneakerimages
          .asMap()
          .entries
          .where((entry) =>
          sneakername[entry.key].toLowerCase().contains(query))
          .map((entry) => entry.value)
          .toList();
      _filteredSneakerNames = sneakername
          .asMap()
          .entries
          .where((entry) =>
          sneakername[entry.key].toLowerCase().contains(query))
          .map((entry) => entry.value)
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 140),
        child: Column(
          children: [
            AppBar(
              title:  Text('Air Jordan',style: GoogleFonts.nunitoSans(),),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.nunitoSans(),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _filteredSneakerImages.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  _filteredSneakerImages[index],
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  _filteredSneakerNames[index],
                  style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}