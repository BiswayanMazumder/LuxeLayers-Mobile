import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Favourites%20Page/favourites.dart';
import 'package:luxelayers/Order%20Page/orderpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username = '';
  Future<void> fetchname() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('User Detail').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        username = docsnap.data()!['Name'];
      });
    }
    // print(username);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hey! $username',
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
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
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Orders',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
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
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Wishlist',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Account',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Help Center',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
