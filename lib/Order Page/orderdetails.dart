import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Add%20To%20Cart%20Page/cartpage.dart';
class OrderDetails extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String orderid;
  final bool isdelivered;
  final int price;
  const OrderDetails({
    Key? key,
    required this.name,
    required this.orderid,
    required this.imageUrl,
    required this.isdelivered,
    required this.price,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcartdetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details',style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w600
        ),),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Text('Order ID - ${widget.orderid}',style: GoogleFonts.nunitoSans(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),),
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
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Row(
                  children: [
                    Expanded(child: Column(
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
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Text('Seller: LuxeLayers',style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Text('₹${widget.price}',style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                ),),
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
            ],
          ),
        ),
      ),
    );
  }
}
