import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:luxelayers/Environment%20Variables/.env.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxelayers/Environmental%20Variables/.env.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Product_Details extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String productid;

  const Product_Details({
    Key? key,
    required this.name,
    required this.productid,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<Product_Details> createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  bool isliked = false;
  String price = '';
  bool isfetched = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchprice() async {
    final docsnap =
        await _firestore.collection('sneakers').doc(widget.productid).get();
    if (docsnap.exists) {
      setState(() {
        price = docsnap.data()?['Price'];
        isfetched = true;
      });
    }
    if (kDebugMode) {
      print('Price ${price}');
    }
  }

  Future<void> uploadproductimage() async {
    await _firestore.collection('sneakers').doc(widget.productid).update({
      'Product Image': widget.imageUrl,
      'Avaliable': true,
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<dynamic> cartitems = [];
  bool iscartadded = false;
  Future<void> fetchcartdetails() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Cart Items').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        cartitems = docsnap.data()?['Product ID'];
      });
    }
    if (cartitems.contains(widget.productid)) {
      setState(() {
        iscartadded = true;
      });
    }
  }

  List<dynamic> likeditems = [];
  // bool isliked=false;
  Future<void> fetchlikedetails() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Liked Items').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        likeditems = docsnap.data()?['Product ID'];
      });
    }
    if (likeditems.contains(widget.productid)) {
      setState(() {
        isliked = true;
      });
    }
  }

  Future<void> addlikeitems(bool isliked) async {
    final user = _auth.currentUser;
    if (!isliked) {
      await _firestore.collection('Liked Items').doc(user!.uid).set({
        'Product ID': FieldValue.arrayUnion([widget.productid])
      }, SetOptions(merge: true));
    }
    if (isliked) {
      await _firestore.collection('Liked Items').doc(user!.uid).set({
        'Product ID': FieldValue.arrayRemove([widget.productid])
      }, SetOptions(merge: true));
    }
  }

  Future<void> addcartitems(bool cartitem) async {
    final user = _auth.currentUser;
    if (!cartitem) {
      await _firestore.collection('Cart Items').doc(user!.uid).set({
        'Product ID': FieldValue.arrayUnion([widget.productid])
      }, SetOptions(merge: true));
    }
    if (cartitem) {
      await _firestore.collection('Cart Items').doc(user!.uid).set({
        'Product ID': FieldValue.arrayRemove([widget.productid])
      }, SetOptions(merge: true));
    }
  }

  bool isuk6 = false;
  bool isuk7 = false;
  bool isuk8 = false;
  bool isuk9 = false;
  bool isuk10 = false;
  bool isuk11 = false;
  bool isuk12 = false;
  List<String> categories = [];
  Future<void> fetchshoesizes() async {
    final docsnap =
        await _firestore.collection('sneakers').doc(widget.productid).get();
    if (docsnap.exists) {
      setState(() {
        isuk6 = docsnap.data()?['UK 6'];
        if (isuk6) {
          categories.add('UK 6');
        }
        isuk7 = docsnap.data()?['UK 7'];
        if (isuk7) {
          categories.add('UK 7');
        }
        isuk8 = docsnap.data()?['UK 8'];
        if (isuk8) {
          categories.add('UK 8');
        }
        isuk9 = docsnap.data()?['UK 9'];
        if (isuk9) {
          categories.add('UK 9');
        }
        isuk10 = docsnap.data()?['UK 10'];
        if (isuk10) {
          categories.add('UK 10');
        }
        isuk11 = docsnap.data()?['UK 11'];
        if (isuk11) {
          categories.add('UK 11');
        }
        isuk12 = docsnap.data()?['UK 12'];
        if (isuk12) {
          categories.add('UK 12');
        }
        isfetched = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchprice();
    fetchshoesizes();
    // uploadproductimage();
    fetchcartdetails();
    fetchlikedetails();
    fetchgeminiresponse();
    fetchreviews();
  }

  TextEditingController _review = TextEditingController();
  Future<void> writereviews() async {
    final user = _auth.currentUser;
    final reviewImageUrl = _uploadedImageUrl;

    await _firestore.collection('Reviews').doc(widget.productid).set({
      'Review': FieldValue.arrayUnion([_review.text]),
      'Review Image': reviewImageUrl != null
          ? FieldValue.arrayUnion([reviewImageUrl])
          : FieldValue.arrayUnion([null]),
    }, SetOptions(merge: true));
  }

  List<dynamic> reviewitems = [];
  List<dynamic> reviewphotos = [];
  Future<void> fetchreviews() async {
    final docsnap =
        await _firestore.collection('Reviews').doc(widget.productid).get();
    if (docsnap.exists) {
      setState(() {
        reviewitems = docsnap.data()?['Review'];
        reviewphotos = docsnap.data()?['Review Image'];
      });
      print('Review ${reviewphotos}');
    }
  }

  String? about = '';
  XFile? _selectedImage;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();
  void fetchgeminiresponse() async {
    final apiKey = Environment.Geminiapi;
    if (apiKey == null) {
      if (kDebugMode) {
        print('No \$API_KEY environment variable');
      }
    }
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
    final prompt = '${widget.name} in 100 words';

    final response = await model.generateContent([Content.text(prompt)]);
    setState(() {
      about = response.text;
      isfetched = true;
    });
    if (kDebugMode) {
      print(response.text);
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
      // Optionally, you could directly call `_uploadImageToFirebase(pickedImage)` here
    }
  }

  Future<void> _uploadImageToFirebase(XFile image) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final storageRef = FirebaseStorage.instance.ref().child(
        'reviews/${widget.productid}/${DateTime.now().toIso8601String()}');

    final uploadTask = storageRef.putFile(File(image.path));
    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _uploadedImageUrl = downloadUrl;
    });
  }

  Future<void> _updateFirestoreWithImage(String imageUrl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('Reviews')
        .doc(widget.productid)
        .update({
      'Review Image': FieldValue.arrayUnion([imageUrl])
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: isfetched
            ? BottomAppBar(
                child: Container(
                  // color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '₹$price',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await fetchcartdetails(); // Ensure the cart details are fetched first

                              if (iscartadded) {
                                await addcartitems(
                                    true); // Remove the item from the cart
                              } else {
                                await addcartitems(
                                    false); // Add the item to the cart
                              }

                              setState(() {
                                iscartadded =
                                    !iscartadded; // Toggle the cart status after the operation is complete
                              });
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: iscartadded
                                      ? Colors.yellow
                                      : Colors.green,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  iscartadded ? 'Added To Cart' : 'Add To Cart',
                                  style: GoogleFonts.nunitoSans(
                                      color: iscartadded
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const BottomAppBar(
                color: Colors.white,
              ),
        appBar: AppBar(
          actions: [
            Row(
              children: [
                isfetched
                    ? InkWell(
                        onTap: () async {
                          await fetchlikedetails(); // Ensure the cart details are fetched first

                          if (isliked) {
                            await addlikeitems(
                                true); // Remove the item from the cart
                          } else {
                            await addlikeitems(
                                false); // Add the item to the cart
                          }

                          setState(() {
                            isliked =
                                !isliked; // Toggle the cart status after the operation is complete
                          });
                        },
                        child: Icon(
                          isliked ? Icons.favorite : Icons.favorite_border,
                          color: isliked ? Colors.red : Colors.black,
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
        body: isfetched
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(widget.imageUrl),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Text('Style: ${widget.productid}'),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        about!,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Select Size',
                      style: GoogleFonts.nunitoSans(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0), // Add 30px space from left
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
                                    _selectedIndex =
                                        index; // Update the selected index
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: _selectedIndex == index
                                        ? Colors.green
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
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
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              child: Image.network(widget.imageUrl),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextField(
                              controller: _review,
                              style: GoogleFonts.nunitoSans(),
                              decoration: InputDecoration(
                                  hintText: 'Enter Your Review',
                                  suffixIcon: InkWell(
                                    onTap: () async {
                                      if (_review.text.isNotEmpty) {
                                        // Upload the image if it is selected
                                        if (_selectedImage != null) {
                                          await _uploadImageToFirebase(
                                              _selectedImage!);
                                        }

                                        // Write the review along with the uploaded image URL (if available)
                                        await writereviews();

                                        // Clear the review text field and reset image
                                        _review.clear();
                                        setState(() {
                                          _selectedImage = null;
                                          _uploadedImageUrl =
                                              null; // Ensure to clear the URL if needed
                                        });

                                        // Refresh the reviews
                                        await fetchreviews();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintStyle: GoogleFonts.nunitoSans()),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < reviewitems.length; i++)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                        child: Image.network(
                                          'https://media.istockphoto.com/id/1341046662/vector/picture-profile-icon-human-or-people-sign-and-symbol-for-template-design.jpg?s=612x612&w=0&k=20&c=A7z3OK0fElK3tFntKObma-3a7PyO8_2xxW0jtmjzT78=',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      Text('${reviewitems[i]}'),
                                    ],
                                  ),
                                  if (reviewphotos[i] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Row(
                                        children: [
                                          Image(
                                            image:
                                                NetworkImage(reviewphotos[i]),
                                            height: 200,
                                            width: 200,
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              )));
  }
}
