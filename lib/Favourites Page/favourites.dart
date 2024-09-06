import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Sneaker%20Detail%20Page/productdetails.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> likeditems = [];
  bool isloaded = false;
  Future<void> fetchliked() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Liked Items').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        likeditems = docsnap.data()?['Product ID'] ?? [];
      });
    }
    print('Liked $likeditems');
  }

  List<dynamic> name = [];
  List<dynamic> price = [];
  List<dynamic> image = [];
  List<bool> avaliable = [];
  Future<void> fetchproductdetails() async {
    await fetchliked();
    for (var i = 0; i < likeditems.length; i++) {
      final docsnap =
          await _firestore.collection('sneakers').doc(likeditems[i]).get();
      if (docsnap.exists) {
        setState(() {
          name.add(docsnap.data()?['name'] ?? '');
          price.add(docsnap.data()?['Price'] ?? '');
          image.add(docsnap.data()?['Product Image'] ?? '');
          avaliable.add(docsnap.data()?['Avaliable'] ?? false);
          isloaded = true;
        });
      }
    }
    // print('Name , price , image $name , $price , $image $avaliable');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchliked();
    fetchproductdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Liked Items",
            style: GoogleFonts.nunitoSans(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: ListView.builder(
                  itemCount: likeditems.length,
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
                                  productid: likeditems[index],
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
                                    padding: const EdgeInsets.only(left: 120),
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
                                        avaliable[index]
                                            ? Text(
                                                'In Stock',
                                                style: GoogleFonts.nunitoSans(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : Text(
                                                'Out of Stock',
                                                style: GoogleFonts.nunitoSans(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
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
          ],
        ));
  }
}
