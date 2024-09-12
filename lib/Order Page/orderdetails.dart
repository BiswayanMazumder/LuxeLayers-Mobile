import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luxelayers/Add%20To%20Cart%20Page/cartpage.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';

class OrderDetails extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String orderid;
  final bool isdelivered;
  final int price;
  final String productid;
  const OrderDetails({
    Key? key,
    required this.name,
    required this.orderid,
    required this.imageUrl,
    required this.isdelivered,
    required this.price,
    required this.productid
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<dynamic> cartitems = [];
  double ratings = 0;
  bool isloaded = false;
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

  Future<void> fetchratings() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection(widget.orderid).doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        ratings = docsnap.data()?['Rating Given'];
      });
    }
  }

  DateTime? deliverdate;
  String? formattedDate;
  DateTime? shippingdate;
  String? formattedshippingDate;
  DateTime? outdeliverydate;
  String? formattedoutdeliveryDate;
  DateTime? orderdate;
  String? formattedorderDate;
  Future<void> fetchorderdate() async {
    final docsnap =
        await _firestore.collection('Order Details').doc(widget.orderid).get();
    if (docsnap.exists) {
      setState(() {
        // deliverdate = (docsnap.data()?['Delivery Date'] as Timestamp).toDate();
        orderdate = (docsnap.data()?['Order Date'] as Timestamp).toDate();
        // formattedDate = DateFormat('MMM dd').format(deliverdate!);
        formattedorderDate = DateFormat('MMM dd').format(orderdate!);
      });
    }
    if (kDebugMode) {
      print(formattedorderDate);
    }
  }
  bool isshipped=false;
  bool isoutdelivery=false;
  Future<void> fetchshippingdate() async {
    final docsnap =
    await _firestore.collection('Order Details').doc(widget.orderid).get();
    if (docsnap.exists) {
      setState(() {
        // deliverdate = (docsnap.data()?['Delivery Date'] as Timestamp).toDate();
        shippingdate = (docsnap.data()?['shipped'] as Timestamp).toDate();
        isshipped=docsnap.data()?['Shipped'];
        // formattedDate = DateFormat('MMM dd').format(deliverdate!);
        formattedshippingDate = DateFormat('MMM dd').format(shippingdate!);
      });
    }
    if (kDebugMode) {
      print(formattedshippingDate);
    }
  }
  Future<void> fetchoutdeliverydate() async {
    final docsnap =
    await _firestore.collection('Order Details').doc(widget.orderid).get();
    if (docsnap.exists) {
      setState(() {
        // deliverdate = (docsnap.data()?['Delivery Date'] as Timestamp).toDate();
        outdeliverydate = (docsnap.data()?['Out_Delivery_Time'] as Timestamp).toDate();
        isoutdelivery=docsnap.data()?['Out_Delivery'];
        // formattedDate = DateFormat('MMM dd').format(deliverdate!);
        formattedoutdeliveryDate = DateFormat('MMM dd').format(outdeliverydate!);
      });
    }
    if (kDebugMode) {
      print(formattedshippingDate);
    }
  }
  Future<void> fetchdeliverydate() async {
    final docsnap =
        await _firestore.collection('Order Details').doc(widget.orderid).get();
    if (docsnap.exists) {
      setState(() {
        deliverdate = (docsnap.data()?['Delivery Date'] as Timestamp).toDate();
        // orderdate = (docsnap.data()?['Order Date'] as Timestamp).toDate();
        formattedDate = DateFormat('MMM dd').format(deliverdate!);
        // formattedorderDate = DateFormat('MMM dd').format(orderdate!);
      });
    }
    if (kDebugMode) {
      print(formattedDate);
    }
  }

  List<dynamic> recentlyviewed = [];
  Future<void> fetchrecentlyviewed() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Recently Viewed').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        recentlyviewed = docsnap.data()?['Product ID'] ?? [];
      });
    }
    if (kDebugMode) {
      print(recentlyviewed);
    }
  }

  List<dynamic> name = [];
  List<dynamic> price = [];
  List<dynamic> image = [];
  List<bool> availability = [];
  Future<void> fetchCartProductDetails() async {
    await fetchrecentlyviewed();
    for (int i = 0; i < recentlyviewed.length; i++) {
      final docsnap =
          await _firestore.collection('sneakers').doc(recentlyviewed[i]).get();
      if (docsnap.exists) {
        setState(() {
          name.add(docsnap.data()?['name']);
          price.add(int.parse(docsnap.data()?['Price'] ?? '0'));
          image.add(docsnap.data()?['Product Image']);
        });
      }
    }
  }
  bool _isLoading = true; // Loading state
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.wait([
      fetchcartdetails(),
      fetchratings(),
      fetchorderdate(),
      widget.isdelivered ? fetchdeliverydate() : Future.value(),
      fetchCartProductDetails(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
    fetchshippingdate();
    fetchoutdeliverydate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
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
      body:  _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  'Order ID - ${widget.orderid}',
                  style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 0,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Product_Details(
                        name: widget.name,
                        productid: widget.productid,
                        imageUrl: widget.imageUrl,
                        isjordan: false,
                        isslides: false),));
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 3,
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 30,
                      ),
                      Image.network(
                        widget.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  'Seller: LuxeLayers',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  '₹${widget.price}',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  'Estimated delivery by $formattedorderDate',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 0,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '  Order confirmed on $formattedorderDate',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: SizedBox(
                          height: 80,
                          child: Container(
                            width: 3,
                            decoration: BoxDecoration(
                              color: isshipped ? Colors.green : null,
                              gradient: isshipped
                                  ? null
                                  : const LinearGradient(
                                      colors: [Colors.green, Colors.red],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          isshipped ? Colors.green : Colors.red,
                          child: Icon(
                            isshipped ? Icons.check : Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        isshipped
                            ? Text(
                                '  Order shipped on $formattedshippingDate',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              )
                            : Text(
                                '  Expected to ship at the earliest',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: SizedBox(
                          height: 80,
                          child: Container(
                            width: 3,
                            decoration: BoxDecoration(
                              color: widget.isdelivered ? Colors.green : null,
                              gradient: widget.isdelivered
                                  ? null
                                  : const LinearGradient(
                                colors: [Colors.green, Colors.red],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          isoutdelivery ? Colors.green : Colors.red,
                          child: Icon(
                            isoutdelivery ? Icons.check : Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        isoutdelivery
                            ? Text(
                          '  Order out for delivery on $formattedoutdeliveryDate',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )
                            : Text(
                          '  Item not yet out of delivery',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: SizedBox(
                          height: 80,
                          child: Container(
                            width: 3,
                            decoration: BoxDecoration(
                              color: widget.isdelivered ? Colors.green : null,
                              gradient: widget.isdelivered
                                  ? null
                                  : const LinearGradient(
                                colors: [Colors.green, Colors.red],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          widget.isdelivered ? Colors.green : Colors.red,
                          child: Icon(
                            widget.isdelivered ? Icons.check : Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        widget.isdelivered
                            ? Text(
                          '  Order confirmed on $formattedDate',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )
                            : Text(
                          '  Order yet to be delivered',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.isdelivered
                  ? Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rate your experience',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: RatingBar.builder(
                              initialRating: ratings,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glowColor: Colors.black,
                              glow: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              onRatingUpdate: (rating) async {
                                final user = _auth.currentUser;
                                await _firestore
                                    .collection(widget.orderid)
                                    .doc(user!.uid)
                                    .set({'Rating Given': rating});
                                await _firestore
                                    .collection('Ratings')
                                    .doc(widget.orderid)
                                    .set({'Rating Given': rating});
                                await fetchratings();
                                if (kDebugMode) {
                                  print(rating);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Recently Viewed Items',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    ]),
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
                                    isjordan: false,
                                    isslides: false,
                                    productid: recentlyviewed[index],
                                    imageUrl: image[index]),
                              ),
                            );
                          },
                          child: Image.network(
                            image[index],
                            height: 20,
                            // width: 0,
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
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'You might be interested in',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    ]),
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
                                    isjordan: false,
                                    isslides: false,
                                    productid: recentlyviewed[index],
                                    imageUrl: image[index]),
                              ),
                            );
                          },
                          child: Image.network(
                            image[index],
                            height: 20,
                            // width: 0,
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
        ),
      ),
    );
  }
}
