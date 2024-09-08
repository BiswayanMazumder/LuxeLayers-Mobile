import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luxelayers/Favourites%20Page/favourites.dart';
import 'package:luxelayers/Help%20Desk/helpdesk.dart';
import 'package:luxelayers/Order%20Page/orderpage.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? _selectedindex;
  List<dynamic> cartitems = [];
  List<dynamic> name = [];
  List<dynamic> price = [];
  List<dynamic> image = [];
  List<bool> availability = [];
  bool isLoaded = false;
  double total = 0.0;
  bool isAvailable = true;
  String username = '';

  Future<void> fetchCartDetails() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Recently Viewed').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        cartitems = docsnap.data()?['Product ID'] ?? [];
      });
    }
  }

  Future<void> fetchCartProductDetails() async {
    await fetchCartDetails();

    for (int i = 0; i < cartitems.length; i++) {
      final docsnap =
          await _firestore.collection('sneakers').doc(cartitems[i]).get();
      if (docsnap.exists) {
        setState(() {
          name.add(docsnap.data()?['name']);
          price.add(int.parse(docsnap.data()?['Price'] ?? '0'));
          image.add(docsnap.data()?['Product Image']);
          // availability.add(docsnap.data()?['Available']);
          isLoaded = true;
        });
      }
    }

    double calculatedTotal = 0.0;
    bool availabilityFlag = false;

    for (int i = 0; i < availability.length; i++) {
      if (availability[i]) {
        calculatedTotal += price[i];
        availabilityFlag = true;
      }
    }

    setState(() {
      total = calculatedTotal;
      isAvailable = availabilityFlag;
    });
  }

  Future<void> fetchName() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('User Detail').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        username = docsnap.data()?['Name'] ?? '';
      });
    }
  }

  void getlanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedindex = prefs.getInt('Language');
    });
    print(_selectedindex);
  }

  @override
  void initState() {
    super.initState();
    fetchName();
    fetchCartProductDetails();
    getlanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _selectedindex == 0 ? 'Hey! $username' : 'हाय $username',
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyOrders(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          _selectedindex == 0 ? 'Orders' : 'आर्डर',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouritePage(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          _selectedindex == 0 ? 'Wishlist' : 'इच्छा सूची',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        _selectedindex == 0 ? 'Account' : 'खाता',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpHomePage(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          _selectedindex == 0 ? 'Help Center' : 'सहायता केंद्र',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await _auth.currentUser!.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Verification email sent',
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Error sending verification mail',
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                      );
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Please ',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'verify',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: ' your email to make any changes',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedindex == 0
                        ? 'Recently Viewed Stores'
                        : '"हाल ही में देखे गए स्टोर"',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 150, // Height of the ListView
                    // width: 50,
                    child: ListView.builder(
                      itemCount: image.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Product_Details(
                                        name: name[index],
                                        isjordan: index == 0 ? true : false,
                                        isslides: index == 1 ? false : true,
                                        productid: cartitems[index],
                                        imageUrl: image[index]),
                                  ),
                                );
                              },
                              child: Image.network(
                                image[index],

                                fit: BoxFit.cover,
                                // width: 50, // Width of each image
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  );
                                },
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    _selectedindex == 0
                        ? 'Try LuxeLayers in your language'
                        : '"LuxeLayers" को हिंदी में "लक्सलेयर्स" कहा जा सकता है।',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _selectedindex = 0;
                            });
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setInt('Language', _selectedindex!);
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _selectedindex == 0
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: _selectedindex == 0
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: _selectedindex == 0 ? 2 : 1),
                            ),
                            child: Center(
                              child: Text(
                                'English',
                                style: GoogleFonts.nunitoSans(
                                  color: _selectedindex == 0
                                      ? Colors.blue
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _selectedindex = 1;
                            });
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setInt('Language', _selectedindex!);
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _selectedindex == 1
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: _selectedindex == 1
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: _selectedindex == 1 ? 2 : 1),
                            ),
                            child: Center(
                              child: Text(
                                'हिंदी',
                                style: GoogleFonts.nunitoSans(
                                  color: _selectedindex == 1
                                      ? Colors.blue
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
