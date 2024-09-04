import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';

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
  Future<void> fetchcartproductdetails() async {
    await fetchcartdetails();

    for (int i = 0; i < cartitems.length; i++) {
      final docsnap =
          await _firestore.collection('sneakers').doc(cartitems[i]).get();
      if (docsnap.exists) {
        setState(() {
          name.add(docsnap.data()?['name']);
          price.add(docsnap.data()?['Price']);
          image.add(docsnap.data()?['Product Image']);
          avaliability.add(docsnap.data()?['Avaliable']);
          isloaded = true;
        });
      }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: GoogleFonts.nunitoSans(),
        ),
      ),
      body: isloaded
          ? Padding(
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
                                    productid: cartitems[index],
                                    imageUrl: image[index]),
                              ));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
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
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120),
                                  child: Row(
                                    children: [
                                      Text('₹${price[index]}',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 120, top: 10),
                                  child: Row(
                                    children: [
                                      avaliability[index]
                                          ? Text(
                                              'In Stock',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : Text('Out of Stock',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
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
