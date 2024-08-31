import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';

class JordanPage extends StatefulWidget {
  const JordanPage({super.key});

  @override
  State<JordanPage> createState() => _JordanPageState();
}

class _JordanPageState extends State<JordanPage> {
  List<String> sneakerimages = [
    "https://images.vegnonveg.com/resized/400X328/11393/air-jordan-1-low-off-noirarchaeo-brown-sail-brown-66b362b30f4dc.jpg",
    "https://images.vegnonveg.com/resized/400X328/11393/air-jordan-1-low-off-noirarchaeo-brown-sail-brown-66b362b35ce83.jpg",
    "https://images.vegnonveg.com/resized/400X328/11422/air-jordan-4-retro-se-smoke-greyiron-grey-cement-grey-grey-66b48d859813d.jpg",
    "https://images.vegnonveg.com/resized/400X328/11422/air-jordan-4-retro-se-smoke-greyiron-grey-cement-grey-grey-66b48d8603d63.jpg",
    "https://images.vegnonveg.com/resized/400X328/11425/air-jordan-1-low-whitemetallic-gold-black-white-66bb4992d8cb4.jpg",
    "https://images.vegnonveg.com/resized/400X328/11425/air-jordan-1-low-whitemetallic-gold-black-white-66bb499322a13.jpg",
    "https://images.vegnonveg.com/resized/400X328/11381/air-jordan-1-mid-se-whiteoxidized-green-sail-neutral-grey-white-66a8c651cc6f3.jpg",
    "https://images.vegnonveg.com/resized/400X328/11247/air-jordan-1-low-se-oxidized-greenwhite-sail-green-66a8c54429f5d.jpg",
    "https://images.vegnonveg.com/resized/400X328/11247/air-jordan-1-low-se-oxidized-greenwhite-sail-green-66a8c544725c4.jpg",
    "https://images.vegnonveg.com/resized/400X328/11241/air-jordan-1-low-se-hemplight-british-tan-sail-oatmeal-brown-667d3e4f7c748.jpg",
    "https://images.vegnonveg.com/resized/400X328/11241/air-jordan-1-low-se-hemplight-british-tan-sail-oatmeal-brown-667d3e4fd25f1.jpg",
    "https://images.vegnonveg.com/resized/400X328/11429/air-jordan-4-retro-blackwhite-black_1-66c71921807e0.jpg",
    "https://images.vegnonveg.com/resized/400X328/11429/air-jordan-4-retro-blackwhite-black_1-66c71921c754a.jpg",
    "https://images.vegnonveg.com/resized/400X328/11428/air-jordan-4-retro-blackwhite-black-66c718d11e771.jpg",
    "https://images.vegnonveg.com/resized/400X328/11426/air-jordan-1-mid-saillight-dew-muslin-white-66bb4a42e2b7a.jpg",
    "https://images.vegnonveg.com/resized/400X328/11426/air-jordan-1-mid-saillight-dew-muslin-white-66bb4a431e495.jpg",
    "https://images.vegnonveg.com/resized/400X328/11216/air-jordan-11-retro-low-whitemidnight-navy-diffused-blue-white-6662eaf4ed74c.jpg",
    "https://images.vegnonveg.com/resized/400X328/11216/air-jordan-11-retro-low-whitemidnight-navy-diffused-blue-white-6662eaf5294de.jpg",
    "https://images.vegnonveg.com/resized/400X328/11395/air-jordan-5-retro-whiteblack-sail-metallic-silver-white-66b365aa44059.jpg",
    "https://images.vegnonveg.com/resized/400X328/11394/air-jordan-1-low-whitebordeaux-sail-purple-66b364fe14e20.jpg",
    "https://images.vegnonveg.com/resized/400X328/9805/air-jordan-1-mid-whiteblack-white-64dcc2a91c4af.jpg",
    "https://images.vegnonveg.com/resized/400X328/9805/air-jordan-1-mid-whiteblack-white-64dcc2a979f95.jpg",
    "https://images.vegnonveg.com/resized/400X328/11375/air-jordan-1-retro-high-og-blackmetallic-gold-sail-black_1-66a8c4bbb4277.jpg",
    "https://images.vegnonveg.com/resized/400X328/11375/air-jordan-1-retro-high-og-blackmetallic-gold-sail-black_1-66a8c4bc2d73f.jpg",
    "https://images.vegnonveg.com/resized/400X328/11374/air-jordan-1-retro-high-og-blackmetallic-gold-sail-black-66a8c41a8efe9.jpg",
    "https://images.vegnonveg.com/resized/400X328/11324/air-jordan-1-retro-high-og-university-blueuniversity-gold-sail-blue-6690d2df36ed7.jpg",
    "https://images.vegnonveg.com/resized/400X328/11309/air-jordan-1-low-sailneutral-grey-coconut-milk-grey-6690bb424cd21.jpg",
    "https://images.vegnonveg.com/resized/400X328/11316/air-jordan-1-mid-blackmetallic-gold-white-black-6690bdacce982.jpg",
    "https://images.vegnonveg.com/resized/400X328/11316/air-jordan-1-mid-blackmetallic-gold-white-black-6690bdad1b6da.jpg",
    "https://images.vegnonveg.com/resized/400X328/11306/air-jordan-1-low-whitesky-grey-football-grey-white-6690ba64af00f.jpg",
    "https://images.vegnonveg.com/resized/400X328/11303/air-jordan-1-mid-legend-light-brownsail-muslin-white-6690b3636add7.jpg",
    "https://images.vegnonveg.com/resized/400X328/11352/air-jordan-3-retro-tex-dark-driftwoodsail-hemp-velvet-brown-brown-6690d2874de39.jpg",
    "https://images.vegnonveg.com/resized/400X328/11352/air-jordan-3-retro-tex-dark-driftwoodsail-hemp-velvet-brown-brown-6690d28783e41.jpg",
    "https://images.vegnonveg.com/resized/400X328/11307/air-jordan-1-retro-low-og-whiteblack-wolf-grey-white-6690d206a3124.jpg",
    "https://images.vegnonveg.com/resized/400X328/11307/air-jordan-1-retro-low-og-whiteblack-wolf-grey-white-6690d206dfa2c.jpg",
    "https://images.vegnonveg.com/resized/400X328/11315/air-jordan-1-mid-blackwhite-gym-red-black_1-669113064f7db.jpg",
    "https://images.vegnonveg.com/resized/400X328/11301/air-jordan-1-low-whitewolf-grey-midnight-navy-grey-6690b22d90729.jpg",
    "https://images.vegnonveg.com/resized/400X328/11344/air-jordan-legacy-312-low-whitelight-dew-sail-white-669113bfa0306.jpg",
    "https://images.vegnonveg.com/resized/400X328/11248/air-jordan-1-mid-se-neutral-greysmoke-grey-sail-grey-66865b3831d31.jpg",
    "https://images.vegnonveg.com/resized/400X328/11248/air-jordan-1-mid-se-neutral-greysmoke-grey-sail-grey-66865b386d852.jpg",
    "https://images.vegnonveg.com/resized/400X328/11233/air-jordan-13-retro-dune-redterra-blush-white-red-667549df633ec.jpg",
    "https://images.vegnonveg.com/resized/400X328/10654/air-jordan-1-low-85-whitenavy-blue-65ba3f129749e.jpg"
  ];
  List<String> sneakername = [
    "AIR JORDAN 1 LOW 'OFF NOIR/ARCHAEO BROWN-SAIL'",
    "AIR JORDAN 4 RETRO SE 'SMOKE GREY/IRON GREY-CEMENT GREY'",
    "AIR JORDAN 1 LOW 'WHITE/METALLIC GOLD-BLACK'",
    "AIR JORDAN 1 MID SE 'WHITE/OXIDIZED GREEN-SAIL-NEUTRAL GREY'",
    "AIR JORDAN 1 LOW SE 'OXIDIZED GREEN/WHITE-SAIL'",
    "AIR JORDAN 1 LOW SE 'HEMP/LIGHT BRITISH TAN-SAIL-OATMEAL'",
    "AIR JORDAN 4 RETRO GS 'BLACK/WHITE'",
    "AIR JORDAN 4 RETRO 'BLACK/WHITE'",
    "AIR JORDAN 1 MID 'SAIL/LIGHT DEW-MUSLIN'",
    "AIR JORDAN 11 RETRO LOW 'WHITE/MIDNIGHT NAVY-DIFFUSED BLUE'",
    "AIR JORDAN 5 RETRO 'WHITE/BLACK-SAIL-METALLIC SILVER'",
    "AIR JORDAN 1 LOW 'WHITE/BORDEAUX-SAIL'",
    "AIR JORDAN 1 MID 'WHITE/BLACK'",
    "AIR JORDAN 1 RETRO HIGH OG GS 'BLACK/METALLIC GOLD-SAIL'",
    "AIR JORDAN 1 RETRO HIGH OG 'BLACK/METALLIC GOLD-SAIL'",
    "AIR JORDAN 1 RETRO HIGH OG 'UNIVERSITY BLUE/UNIVERSITY GOLD-SAIL'",
    "AIR JORDAN 1 LOW 'SAIL/NEUTRAL GREY-COCONUT MILK'",
    "AIR JORDAN 1 MID 'BLACK/METALLIC GOLD-WHITE'",
    "AIR JORDAN 1 LOW 'WHITE/SKY GREY-FOOTBALL GREY'",
    "AIR JORDAN 1 MID 'LEGEND LIGHT BROWN/SAIL-MUSLIN'",
    "AIR JORDAN 3 RETRO TEX 'DARK DRIFTWOOD/SAIL-HEMP-VELVET BROWN'",
    "AIR JORDAN 1 RETRO LOW OG 'WHITE/BLACK-WOLF GREY'",
    "AIR JORDAN 1 MID GS 'BLACK/WHITE-GYM RED'",
    "AIR JORDAN 1 LOW 'WHITE/WOLF GREY-MIDNIGHT NAVY'",
    "AIR JORDAN LEGACY 312 LOW 'WHITE/LIGHT DEW-SAIL'",
    "AIR JORDAN 1 MID SE 'NEUTRAL GREY/SMOKE GREY-SAIL'",
    "AIR JORDAN 13 RETRO 'DUNE RED/TERRA BLUSH-WHITE'",
    "AIR JORDAN 1 LOW 85 'WHITE/NAVY'",
    "AIR JORDAN 1 MID 'WHITE/MIDNIGHT NAVY-WOLF GREY'",
    "AIR JORDAN 1 MID 'BLACK/WHITE-GYM RED'",
    "AIR JORDAN 1 RETRO HIGH OG 'SUMMIT WHITE/OBSIDIAN'",
    "AIR JORDAN 1 RETRO LOW OG 'BLACK/GORGE GREEN-VARSITY RED-SAIL'",
    "AIR JORDAN 1 MID SE 'WHITE/INDUSTRIAL BLUE-SAIL'",
    "SPIZIKE LOW PREMIUM 'VARSITY MAIZE/BLACK-WOLF GREY'",
    "AIR JORDAN 4 RETRO 'WHITE/OXIDIZED GREEN-NEUTRAL GREY'",
    "AIR JORDAN 4 RETRO 'WHITE/OXIDIZED GREEN-NEUTRAL GREY'",
    "AIR JORDAN 1 MID SE CRAFT 'PALE IVORY/SAIL-LEGEND LIGHT BROWN'",
    "AIR JORDAN 1 MID SE 'WHITE/METALLIC SILVER-WOLF GREY'",
    "AIR JORDAN 1 LOW SE 'METALLIC SILVER/PHOTON DUST-WOLF GREY'",
    "AIR JORDAN 1 RETRO LOW OG 'NEUTRAL GREY/METALLIC SILVER-WHITE'",
    "AIR JORDAN 1 RETRO LOW OG 'NEUTRAL GREY/METALLIC SILVER-WHITE'",
    "AIR JORDAN 1 LOW MM 'PERFECT PINK/METALLIC GOLD'"
  ];

  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredSneakerImages = [];
  List<String> _filteredSneakerNames = [];
  List<String> documentNames = [];
  Future<void> fetchDocumentNames() async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch the collection
      QuerySnapshot querySnapshot =
          await firestore.collection('sneakers').get();

      // Extract document IDs and add them to the list
      List<String> names = querySnapshot.docs.map((doc) => doc.id).toList();

      setState(() {
        documentNames = names;
      });
      if (kDebugMode) {
        print(documentNames);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching document names: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _filteredSneakerImages = sneakerimages;
    _filteredSneakerNames = sneakername;
    fetchDocumentNames();
    _searchController.addListener(_filterSneakers);
  }

  void _filterSneakers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSneakerImages = sneakerimages
          .asMap()
          .entries
          .where(
              (entry) => sneakername[entry.key].toLowerCase().contains(query))
          .map((entry) => entry.value)
          .toList();
      _filteredSneakerNames = sneakername
          .asMap()
          .entries
          .where(
              (entry) => sneakername[entry.key].toLowerCase().contains(query))
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
              title: Text(
                'Air Jordan',
                style: GoogleFonts.nunitoSans(),
              ),
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
                  child: InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print(documentNames[index]);
                    print(sneakerimages[index]);
                    print(sneakername[index]);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product_Details(
                            name: sneakername[index],
                            imageUrl: sneakerimages[index]),
                      ));
                },
                child: Image.network(
                  _filteredSneakerImages[index],
                  fit: BoxFit.cover,
                ),
              )),
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
