import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> orderids = [];
  List<dynamic> name = [];
  List<dynamic> price = [];
  // List<dynamic> total = [];
  List<dynamic> image = [];
  List<bool> status = [];
  Future<void> fetchorderid() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Order IDs').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        orderids = docsnap.data()!['IDs'];
      });
    }
    print('order id $orderids');
  }

  Future<void> fetchdetails() async {
    await fetchorderid();
    final user = _auth.currentUser;

    for (int i = 0; i < orderids.length; i++) {
      final docSnap = await _firestore
          .collection('Order Details')
          .doc(orderids[i])
          // .collection('Order $orderids[i]')
          .get();

      if (docSnap.exists) {
        final data = docSnap.data()!;

        // Handle Name
        if (data['Name'] is List) {
          // If 'Name' is a list, flatten it
          final List<String> names = List<String>.from(data['Name']);
          name.addAll(names);
        } else {
          // If 'Name' is a single item, add it directly
          name.add(data['Name']);
        }

        // Handle Price
        if (data['Price'] is List) {
          // If 'Price' is a list, flatten it
          final List<int> prices = List<int>.from(data['Price']);
          price.addAll(prices);
        } else {
          // If 'Price' is a single item, add it directly
          price.add(data['Price']);
        }

        // Handle Product Image
        if (data['Product Image'] is List) {
          // If 'Product Image' is a list, flatten it
          final List<String> images = List<String>.from(data['Product Image']);
          image.addAll(images);
        } else {
          // If 'Product Image' is a single item, add it directly
          image.add(data['Product Image']);
        }

        // Handle Delivered Status
        if (data['Delivered'] is List) {
          // If 'Delivered' is a list, flatten it
          final List<bool> statuses = List<bool>.from(data['Delivered']);
          status.addAll(statuses);
        } else {
          // If 'Delivered' is a single item, add it directly
          status.add(data['Delivered']);
        }
      }

      // Debugging outputs
      print('name $name');
      print('price $price');
      print('image $image');
      print('status $status');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorderid();
    fetchdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: ListView.builder(
          itemCount: name.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  Text(
                    name[index],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
