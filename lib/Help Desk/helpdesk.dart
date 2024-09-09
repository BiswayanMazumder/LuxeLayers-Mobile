import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luxelayers/Add%20To%20Cart%20Page/cartpage.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';

class HelpHomePage extends StatefulWidget {
  const HelpHomePage({super.key});

  @override
  State<HelpHomePage> createState() => _HelpHomePageState();
}

class _HelpHomePageState extends State<HelpHomePage> {
  List<dynamic> cartitems = [];
  bool isloaded=false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalcart = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  List<dynamic> allNames = [];
  List<dynamic> allImages = [];
  List<dynamic> allPrices = [];
  List<bool> allStatuses = [];
  Future<void> fetchOrderDetails() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Order IDs').doc(user!.uid).get();
    List<dynamic> orderids = [];

    if (docsnap.exists) {
      orderids = docsnap.data()!['IDs'];
    }

    List<dynamic> names = [];
    List<dynamic> prices = [];
    List<dynamic> images = [];
    List<bool> statuses = [];

    for (int i = 0; i < orderids.length; i++) {
      final docSnap =
          await _firestore.collection('Order Details').doc(orderids[i]).get();

      if (docSnap.exists) {
        final data = docSnap.data()!;

        // Handle Name
        if (data['Name'] is List) {
          names.addAll(data['Name']);
        } else {
          names.add(data['Name']);
        }

        // Handle Price
        if (data['Price'] is List) {
          prices.addAll(data['Price']);
        } else {
          prices.add(data['Price']);
        }

        // Handle Product Image
        if (data['Product Image'] is List) {
          images.addAll(data['Product Image']);
        } else {
          images.add(data['Product Image']);
        }

        // Handle Delivered Status
        if (data['Delivered'] is List) {
          statuses.addAll(data['Delivered']);
        } else {
          statuses.add(data['Delivered']);
        }
      }
    }

    setState(() {
      allNames = names;
      allPrices = prices;
      allImages = images;
      allStatuses = statuses;
      isloaded=true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcartdetails();
    fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '24x7 Customer Support',
          style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
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
                      CupertinoIcons.cart,
                      color: Colors.black,
                      size: 30.0, // Adjust size if necessary
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ));
                      },
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
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )
        ],
      ),
      body:isloaded? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Get quick customer support by selecting your item',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Select the order to track and manage it conveniently',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              for (int i = 0; i < 3; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        if (allImages.length > i)
                          Image.network(
                            allImages[i] as String,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allNames[i] as String,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    '₹${allPrices[i].toString()}',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 10),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(20),
                                //       border: Border.all(
                                //           color: Colors.grey, width: 1),
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(5.0),
                                //       child: Text(
                                //         'Ordered By $username',
                                //         overflow: TextOverflow.ellipsis,
                                //         style: GoogleFonts.nunitoSans(
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 10,
                                //         ),
                                //         maxLines: 1,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'View more',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'What issues are you facing?',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                // height: 100,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I want to manage my order',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'View,cancel or help an order',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600, fontSize: 15,color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                // height: 100,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I want help with return and refunds',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Manage and track orders',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600, fontSize: 15,color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                // height: 100,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I want help with other issues',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Offer, payments or any other issues',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600, fontSize: 15,color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ): Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          Center(
            child: Text(
              '\nLoading',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
