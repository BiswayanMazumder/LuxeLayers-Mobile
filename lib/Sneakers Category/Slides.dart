import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlidesPage extends StatefulWidget {
  const SlidesPage({super.key});

  @override
  State<SlidesPage> createState() => _JordanPageState();
}

class _JordanPageState extends State<SlidesPage> {
  List<String> sneakerimages = [
    // "https://images.vegnonveg.com/media/collections/75/171955723875667e5c76f082e.png",
    "https://images.vegnonveg.com/resized/400X328/11240/jordan-jumpman-slide-neutral-greymetallic-silver-grey-667d41362b384.jpg",
    "https://images.vegnonveg.com/resized/400X328/11225/calm-sandal-light-bone-cream-666a83e84e6a9.jpg",
    "https://images.vegnonveg.com/resized/400X328/11225/calm-sandal-light-bone-cream-666a83e87116a.jpg",
    "https://images.vegnonveg.com/resized/400X328/11244/calm-slide-se-glacier-blue-blue-66865e0f385b4.jpg",
    "https://images.vegnonveg.com/resized/400X328/11244/calm-slide-se-glacier-blue-blue-66865e0f57cce.jpg",
    "https://images.vegnonveg.com/resized/400X328/11245/icon-classic-sandal-blackwhite-black-66865eb998bb6.jpg",
    "https://images.vegnonveg.com/resized/400X328/11191/calm-slide-game-royal-blue-66508c815106c.jpg",
    "https://images.vegnonveg.com/resized/400X328/10916/jordan-super-play-slide-blackphantom-anthracite-black-660ff53055b50.jpg",
    "https://images.vegnonveg.com/resized/400X328/10916/jordan-super-play-slide-blackphantom-anthracite-black-660ff5308138c.jpg",
    "https://images.vegnonveg.com/resized/400X328/11060/calm-sandal-black-black_1-6634824205ed5.jpg",
    "https://images.vegnonveg.com/resized/400X328/11060/calm-sandal-black-black_1-663482421f859.jpg",
    "https://images.vegnonveg.com/resized/400X328/10901/air-max-1-slide-whiteroyal-blue-black-light-neutral-grey-blue-660e942f103d7.jpg",
    "https://images.vegnonveg.com/resized/400X328/11474/calm-slide-flat-pewter-grey-66c71665c9e1c.jpg",
    "https://images.vegnonveg.com/resized/400X328/11436/chuck-70-mule-slip-egretblack-black-66c6d00abb1b9.jpg",
    "https://images.vegnonveg.com/resized/400X328/11439/run-star-utility-sandal-cx-ox-egret-cream-66c6d2efece41.jpg"
  ];
  List<String> sneakername = [ "JORDAN JUMPMAN SLIDE NEUTRAL GREY/METALLIC SILVER",
    "CALM SANDAL LIGHT BONE",
    "CALM SLIDE SE GLACIER BLUE",
    "ICON CLASSIC SANDAL BLACK/WHITE",
    "CALM SLIDE GAME ROYAL",
    "SUPER PLAY SLIDE BLACK/PHANTOM-ANTHRACITE",
    "CALM SANDAL BLACK",
    "AIR MAX 1 SLIDE WHITE/ROYAL BLUE-BLACK-LIGHT NEUTRAL GREY",
    "CALM SLIDE FLAT PEWTER",
    "CHUCK 70 MULE SLIP EGRET/BLACK",
    "RUN STAR UTILITY SANDAL CX OX EGRET",
    "RUN STAR UTILITY SANDAL CX OX BLACK",
    "AIR MAX CIRRO SLIDE DARK SMOKE GREY/COOL GREY",
    "CALM MULE FLAX",
    "ICON CLASSIC SANDAL SE ARMORY NAVY/FLAX-SAIL"];
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