import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Add%20To%20Cart%20Page/cartpage.dart';
import 'package:luxelayers/Login%20and%20Signup%20Page/getstarted.dart';
import 'package:luxelayers/Sneakers%20Category/Slides.dart';
import 'package:luxelayers/Sneakers%20Category/dunks.dart';
import 'package:luxelayers/Sneakers%20Category/jordan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> imageUrls = [
    'https://images.vegnonveg.com/media/collections/102/172007371710266863df57389e.png',
    'https://images.vegnonveg.com/media/collections/75/171955723875667e5c76f082e.png',
    'https://images.vegnonveg.com/media/collections/101/17198391211016682a991ee9b7.png',
    // Add more image URLs here
  ];
  List<String> categories = [
    'All',
    'Air Jordan',
    'Slides',
    'Dunks',
    'Air Max',
    'Air Force'
  ];
  List<String> sneakerimages = [];
  int _selectedIndex = 0; // Track the selected index
  List<String> jordans = [
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
  List<String> slides = [
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
  List<String> dunks = [
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
  List<String> airmax = [
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
  List<String> airforce = [
    "https://images.vegnonveg.com/resized/400X328/11317/air-force-1-shadow-sailcacao-wow-flax-sesame-white-6690be258346c.jpg",
    "https://images.vegnonveg.com/resized/400X328/11226/air-force-1-07-lv8-light-british-tanburgundy-crush-brown-666a86b38436d.jpg",
    "https://images.vegnonveg.com/resized/400X328/11336/air-force-1-07-lv8-1-coconut-milkvintage-green-bicoastal-white-6690cdf402403.jpg",
    "https://images.vegnonveg.com/resized/400X328/11257/air-force-1-07-nn-hydrangeasblack-raspberry-barely-grape-purple-66865dbe70bcc.jpg",
    "https://images.vegnonveg.com/resized/400X328/11195/air-force-1-07-saillimestone-pale-vanilla-coconut-milk-cream-66508e9ee2809.jpg",
    "https://images.vegnonveg.com/resized/400X328/11326/air-force-1-07-whiteuniversity-gold-white-6690c18e24b7c.jpg",
    "https://images.vegnonveg.com/resized/400X328/8772/air-force-1-07-blackwhite-black_1-63bbfb21984a4.jpg",
    "https://images.vegnonveg.com/resized/400X328/11475/air-force-1-07-whitedragon-red-white-white-66c717cce8961.jpg"
  ];
  @override
  void initState() {
    fetchcartdetails();
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < jordans.length; i++) {
      sneakerimages.add(jordans[i]);
    }
    for (int j = 0; j < slides.length; j++) {
      sneakerimages.add(slides[j]);
    }
    for (int j = 0; j < dunks.length; j++) {
      sneakerimages.add(dunks[j]);
    }
    for (int j = 0; j < airmax.length; j++) {
      sneakerimages.add(airmax[j]);
    }
    for (int j = 0; j < airforce.length; j++) {
      sneakerimages.add(airforce[j]);
    }
  }

  List<dynamic> cartitems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalcart = 0;
  Future<void> fetchcartdetails() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Cart Items').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        cartitems = docsnap.data()?['Product ID'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Discover',
          style:
              GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ));
                      },
                      child: const Icon(
                        CupertinoIcons.bag,
                        color: Colors.black,
                        size: 30.0, // Adjust size if necessary
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            cartitems.length.toString(),
                            style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetStartedPage(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.login,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the start
          children: [
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: PageView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const JordanPage(),
                              ));
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SlidesPage(),
                              ));
                        } else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DunksPage(),
                              ));
                        }
                      },
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  // const Spacer(),
                  // InkWell(
                  //   onTap: () {
                  //     if (kDebugMode) {
                  //       print('Clicked');
                  //     }
                  //   },
                  //   child: Text(
                  //     'See All',
                  //     style: GoogleFonts.nunitoSans(
                  //         color: Colors.green,
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 15),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 5.0), // Add 30px space from left
              child: SizedBox(
                height: 50, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Horizontal scroll
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index; // Update the selected index
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 80,
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: _selectedIndex == index
                                    ? Colors.green
                                    : Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: GoogleFonts.nunitoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            _selectedIndex == 0
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 300, // Set a specific height if needed
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0, // Add spacing between items
                          mainAxisSpacing: 10.0, // Add spacing between items
                        ),
                        itemCount: sneakerimages.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Image.network(
                              sneakerimages[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : _selectedIndex == 1
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 300, // Set a specific height if needed
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing:
                                  10.0, // Add spacing between items
                              mainAxisSpacing:
                                  10.0, // Add spacing between items
                            ),
                            itemCount: jordans.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Image.network(
                                  jordans[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : _selectedIndex == 2
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 300, // Set a specific height if needed
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing:
                                      10.0, // Add spacing between items
                                  mainAxisSpacing:
                                      10.0, // Add spacing between items
                                ),
                                itemCount: slides.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Image.network(
                                      slides[index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : _selectedIndex == 3
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height:
                                      300, // Set a specific height if needed
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing:
                                          10.0, // Add spacing between items
                                      mainAxisSpacing:
                                          10.0, // Add spacing between items
                                    ),
                                    itemCount: dunks.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Image.network(
                                          dunks[index],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : _selectedIndex == 4
                                ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height:
                                          300, // Set a specific height if needed
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing:
                                              10.0, // Add spacing between items
                                          mainAxisSpacing:
                                              10.0, // Add spacing between items
                                        ),
                                        itemCount: airmax.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Image.network(
                                              airmax[index],
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height:
                                          300, // Set a specific height if needed
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing:
                                              10.0, // Add spacing between items
                                          mainAxisSpacing:
                                              10.0, // Add spacing between items
                                        ),
                                        itemCount: airforce.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Image.network(
                                              airforce[index],
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
          ],
        ),
      ),
    );
  }
}
