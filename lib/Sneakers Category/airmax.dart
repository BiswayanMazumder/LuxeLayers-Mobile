import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';

class AirmaxPage extends StatefulWidget {
  const AirmaxPage({super.key});

  @override
  State<AirmaxPage> createState() => _AirmaxPageState();
}

class _AirmaxPageState extends State<AirmaxPage> {
  List<String> sneakerimages = [
    "https://images.vegnonveg.com/resized/400X328/11473/air-max-90-drift-action-greenblack-summit-white-green-66c6f5a6b95b7.jpg",
    "https://images.vegnonveg.com/resized/400X328/11421/air-max-1-whitelight-army-neutral-grey-black-white-66b47248b5e8d.jpg",
    "https://images.vegnonveg.com/resized/400X328/11421/air-max-1-whitelight-army-neutral-grey-black-white-66b4724907e18.jpg",
    "https://images.vegnonveg.com/resized/400X328/11420/air-max-90-whitekhaki-cyber-dark-smoke-grey-white-66b4720bd006d.jpg",
    "https://images.vegnonveg.com/resized/400X328/11420/air-max-90-whitekhaki-cyber-dark-smoke-grey-white-66b4720c2227d.jpg",
    "https://images.vegnonveg.com/resized/400X328/11405/air-max-plus-premium-black-teablack-petra-brown-olive-grey-black-66b478d3d7fd6.jpg",
    "https://images.vegnonveg.com/resized/400X328/11404/air-max-1-essential-premium-neutral-oliveblack-cargo-khaki-green-66b495cfd64d0.jpg",
    "https://images.vegnonveg.com/resized/400X328/11402/air-max-1-essential-whiteblack-summit-white-white-66b4760314a84.jpg",
    "https://images.vegnonveg.com/resized/400X328/11402/air-max-1-essential-whiteblack-summit-white-white-66b47603619dc.jpg",
    "https://images.vegnonveg.com/resized/400X328/11388/air-max-sndr-hyper-pinkblack-white-pink-66b0bb285d92c.jpg",
    "https://images.vegnonveg.com/resized/400X328/11388/air-max-sndr-hyper-pinkblack-white-pink-66b0bb29104e2.jpg",
    "https://images.vegnonveg.com/resized/400X328/11369/air-max-1-86-og-light-smoke-greymetallic-silver-grey-66a8c87a72f58.jpg",
    "https://images.vegnonveg.com/resized/400X328/11347/air-max-dn-se-premium-multicolor-multicolor-669a1ca7d4f65.jpg",
    "https://images.vegnonveg.com/resized/400X328/11341/air-max-90-nn-whitemetallic-gold-obsidian-white-6690cf0645ec5.jpg",
    "https://images.vegnonveg.com/resized/400X328/11338/air-max-90-lv8-sailred-stardust-summit-white-white-66979dfc7818e.jpg",
    "https://images.vegnonveg.com/resized/400X328/11338/air-max-90-lv8-sailred-stardust-summit-white-white-66979dfc9987b.jpg",
    "https://images.vegnonveg.com/resized/400X328/11339/air-max-90-lv8-sailbarely-green-summit-white-white-66979eb0553b8.jpg",
    "https://images.vegnonveg.com/resized/400X328/11314/air-max-90-blackwhite-stadium-green-black-6690bd35add59.jpg",
    "https://images.vegnonveg.com/resized/400X328/11318/air-max-1-whiteaster-pink-light-orewood-brown-black-white-6690bef729bc8.jpg",
    "https://images.vegnonveg.com/resized/400X328/11313/air-max-90-whitelight-silver-aster-pink-black-white-6690bcde1eab5.jpg",
    "https://images.vegnonveg.com/resized/400X328/11328/air-max-1-coconut-milkburgundy-crush-armory-navy-white-6690c23b15864.jpg"
  ];
  List<String> sneakername = [
    "AIR MAX SNDR FADE 'CANYON GOLD/DEEP OCEAN-LIGHT SMOKE GREY-SPEED YELLOW-WHITE'",
    "AIR MAX 90 DRIFT 'ACTION GREEN/BLACK-SUMMIT WHITE'",
    "AIR MAX 1 'WHITE/LIGHT ARMY-NEUTRAL GREY-BLACK'",
    "AIR MAX 90 'WHITE/KHAKI-CYBER-DARK SMOKE GREY'",
    "AIR MAX PLUS PREMIUM 'BLACK TEA/BLACK-PETRA BROWN-OLIVE GREY'",
    "AIR MAX 1 ESSENTIAL PREMIUM 'NEUTRAL OLIVE/BLACK-CARGO KHAKI'",
    "AIR MAX 1 ESSENTIAL 'WHITE/BLACK-SUMMIT WHITE'",
    "AIR MAX SNDR 'HYPER PINK/BLACK-WHITE'",
    "AIR MAX 1 '86 OG 'LIGHT SMOKE GREY/METALLIC SILVER'",
    "AIR MAX 90 NN 'WHITE/METALLIC GOLD-OBSIDIAN'",
    "AIR MAX 90 LV8 'SAIL/BARELY GREEN-SUMMIT WHITE'",
    "AIR MAX 90 LV8 'SAIL/RED STARDUST-SUMMIT WHITE'",
    "AIR MAX 90 'BLACK/WHITE-STADIUM GREEN'",
    "AIR MAX 1 'WHITE/ASTER PINK-LIGHT OREWOOD BROWN-BLACK'",
    "AIR MAX 90 'WHITE/LIGHT SILVER-ASTER PINK-BLACK'",
    "AIR MAX 1 'COCONUT MILK/BURGUNDY CRUSH-ARMORY NAVY'",
    "AIR MAX 1 '86 OG 'EARTH/LIGHT LEMON TWIST-OIL GREEN'",
    "AIR MAX 1 'SUMMIT WHITE/BURGUNDY CRUSH-PICANTE RED'",
    "AIR MAX 90 'WHITE/BLACK-DARK TEAM RED-PURE PLATINUM'",
    "AIR MAX 1 'WHITE/UNIVERSITY RED-CREAM-LIMESTONE'",
    "AIR MAX 90 LV8 'SAIL/WHITE-COCONUT MILK-PALE VANILLA'",
    "AIR MAX 1 'PLATINUM TINT/DARK OBSIDIAN-WOLF GREY'",
    "AIR MAX ISLA SANDAL 'BLACK/ANTHRACITE'",
    "AIR MAX DN 'BLACK/DARK SMOKE GREY-DARK GREY-ANTHRACITE'"
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
      QuerySnapshot querySnapshot = await firestore.collection('airmax').get();

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> generateRandomNumber(int index) async {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rng = Random();

    // Generate a random document name once
    String docName =
        List.generate(10, (_) => chars[rng.nextInt(chars.length)]).join();

    // Print the generated document name
    print(docName);

    // Set the same document name in the 'Slides' collection
    await _firestore.collection('airmax').doc(docName).set({
      'Avaliable': true,
      'Product Image': sneakerimages[index],
      'name': sneakername[index],
      'Price': "12500",
      'UK 6': true,
      'UK 7': true,
      'UK 8': true,
      'UK 9': true,
      'UK 10': true,
      'UK 11': true,
      'UK 12': true,
    });
    await _firestore.collection('sneakers').doc(docName).set({
      'Avaliable': true,
      'Product Image': sneakerimages[index],
      'name': sneakername[index],
      'Price': "12500",
      'UK 6': true,
      'UK 7': true,
      'UK 8': true,
      'UK 9': true,
      'UK 10': true,
      'UK 11': true,
      'UK 12': true,
    });
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
                'Airmax',
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
                            isjordan: false,
                            isslides: true,
                            productid: documentNames[index],
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
