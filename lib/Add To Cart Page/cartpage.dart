import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Environmental%20Variables/.env.dart';
import 'package:luxelayers/Logged%20In%20Page/homepage.dart';
import 'package:luxelayers/Navbar/navbar.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:math';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    // print(cartitems);
  }

  List<dynamic> name = [];
  List<dynamic> price = [];
  List<dynamic> image = [];
  List<bool> avaliability = [];
  bool isloaded = false;
  double total = 0.0;
  bool isavaliable = true;
  Future<void> fetchcartproductdetails() async {
    await fetchcartdetails();

    for (int i = 0; i < cartitems.length; i++) {
      final docsnap =
          await _firestore.collection('sneakers').doc(cartitems[i]).get();
      if (docsnap.exists) {
        setState(() {
          name.add(docsnap.data()?['name']);
          price.add(int.parse(docsnap.data()?['Price']));
          image.add(docsnap.data()?['Product Image']);
          avaliability.add(docsnap.data()?['Avaliable']);
          isloaded = true;
        });
      }
      for (int i = 0; i < avaliability.length; i++) {
        if (avaliability[i]) {
          setState(() {
            total += price[i];
          });
        }
      }
      int count = 0;
      for (int j = 0; j < avaliability.length; j++) {
        if (avaliability[j] == false) {
          count += 1;
        }
      }
      // print(count);
      if (count == avaliability.length) {
        setState(() {
          isavaliable = false;
        });
      } else {
        setState(() {
          isavaliable = true;
        });
      }
      // print('Avaliable: $isavaliable');
      // print('total $total');
      // print('Name $name');
      // print('Price $price');
      // print('Image $image');
      // print('Avaliability $avaliability');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcartdetails();
    fetchcartproductdetails();
    // calculateTotalPrice();
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    final random = Random();
    int number = 100000 + random.nextInt(900000);
    String orderid = 'CT${number}';
    final user = _auth.currentUser;
    await _firestore.collection('Order IDs').doc(user!.uid).set({
      'IDs': FieldValue.arrayUnion([orderid])
    }, SetOptions(merge: true));
    await _firestore.collection('Order Details').doc(orderid).set({
      'Name': name,
      'Price': price,
      'Product Image': image,
      'Total': (total + (total > 14000.0 ? 0 : 500) + (total * 0.12))
          .toStringAsFixed(2),
      'Order ID': orderid,
      'Delivered': false
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(),
        ));
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    // showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '₹${(total + (total > 14000.0 ? 0 : 500) + (total * 0.12)).toStringAsFixed(2)}',
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      if (cartitems.isNotEmpty && isavaliable) {
                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': Environment.keyid,
                          'amount': ((total +
                                      (total > 14000.0 ? 0 : 500) +
                                      (total * 0.12)) *
                                  100)
                              .toStringAsFixed(2),
                          'name': 'LuxeLayers',
                          'description':
                              'Order #${DateTime.now().toIso8601String()}',
                          'retry': {'enabled': true, 'max_count': 1},
                          'send_sms_hash': true,
                          'prefill': {
                            // 'contact': '',
                            'email': _auth.currentUser!.email
                          },
                          'external': {
                            'wallets': ['paytm']
                          }
                        };
                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                            handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                            handleExternalWalletSelected);
                        razorpay.open(options);
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: cartitems.isNotEmpty
                              ? isavaliable
                                  ? Colors.green
                                  : Colors.grey
                              : Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          cartitems.isNotEmpty
                              ? isavaliable
                                  ? 'Buy Now'
                                  : 'Out Of Stock'
                              : 'No Products In Cart',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: isloaded
          ? Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: ListView.builder(
                      itemCount: cartitems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Product_Details(
                                      name: name[index],
                                      isjordan: true,
                                      isslides: false,
                                      productid: cartitems[index],
                                      imageUrl: image[index],
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: NetworkImage(image[index]),
                                            height: 100,
                                            width: 100,
                                          ),
                                          Expanded(
                                            child: Text(
                                              name[index],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 120),
                                        child: Row(
                                          children: [
                                            Text(
                                              '₹${price[index]}',
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 120, top: 10),
                                        child: Row(
                                          children: [
                                            avaliability[index]
                                                ? Text(
                                                    'In Stock',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                : Text(
                                                    'Out of Stock',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                            const SizedBox(width: 20),
                                            InkWell(
                                              onTap: () async {
                                                final user = _auth.currentUser;
                                                final docRef = _firestore
                                                    .collection('Cart Items')
                                                    .doc(user!.uid);

                                                final docSnapshot =
                                                    await docRef.get();
                                                if (docSnapshot.exists) {
                                                  // Handle existing document
                                                } else {
                                                  // Handle non-existing document
                                                }

                                                await docRef.set({
                                                  'Product ID':
                                                      FieldValue.arrayRemove(
                                                          [cartitems[index]])
                                                }, SetOptions(merge: true));

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NavBar(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Remove Item',
                                                style: GoogleFonts.nunitoSans(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '₹${total.toString()}0',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Delivery',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            total > 14000.0 ? '₹0.00' : '₹500.00',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Tax',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '₹${(total * 0.12).toStringAsFixed(2)}',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '₹${(total + (total > 14000.0 ? 0 : 500) + (total * 0.12)).toStringAsFixed(2)}',
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.5),
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              ],
            ),
    );
  }
}
