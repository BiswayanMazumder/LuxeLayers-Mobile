import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Order%20Page/orderdetails.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username = '';
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> allNames = [];
  List<dynamic> allImages = [];
  List<dynamic> allPrices = [];
  List<bool> allStatuses = [];

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
  List<dynamic> orderids = [];
  List<dynamic> allorderids=[];
  Future<void> fetchOrderDetails() async {
    final user = _auth.currentUser;
    final docsnap =
    await _firestore.collection('Order IDs').doc(user!.uid).get();

    if (docsnap.exists) {
      orderids = docsnap.data()!['IDs'];
    }

    List<dynamic> names = [];
    List<dynamic> prices = [];
    List<dynamic> images = [];
    List<bool> statuses = [];
    Map<dynamic, int> orderIdCounts = {}; // Map to track counts of each orderid

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
          // Track the count for this orderid
          orderIdCounts[orderids[i]] = (orderIdCounts[orderids[i]] ?? 0) + (data['Delivered'] as List).length;
        } else {
          // Ensure 'Delivered' is a List with the same length as 'names'
          int numberOfItems = names.length - statuses.length;
          statuses.addAll(
              List.generate(numberOfItems, (index) => data['Delivered']));
          // Track the count for this orderid
          orderIdCounts[orderids[i]] = (orderIdCounts[orderids[i]] ?? 0) + numberOfItems;
        }
      }
    }

    // Populate allorderids based on the orderIdCounts map
    allorderids = [];
    orderIdCounts.forEach((orderid, count) {
      allorderids.addAll(List.generate(count, (index) => orderid));
    });

    setState(() {
      allNames = names;
      allPrices = prices;
      allImages = images;
      allStatuses = statuses;
    });

    if (kDebugMode) {
      print(allorderids);
    }
  }


  @override
  void initState() {
    super.initState();
    fetchname();
    fetchOrderDetails();
    _searchController.addListener(() {
      setState(() {}); // Update the UI when the search query changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<int> get filteredIndexes {
    final query = _searchController.text.toLowerCase();
    return List.generate(allNames.length, (index) {
      final name = allNames[index].toLowerCase();
      return name.contains(query) ? index : null;
    }).where((index) => index != null).cast<int>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          'My Orders',
          style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80), // Adjust height for the TextField
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search orders...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0), // Adjust height by padding
              ),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
          child: allNames.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : filteredIndexes.isEmpty
                  ? Center(
                      child: Text(
                        'No orders found.',
                        style: GoogleFonts.nunitoSans(),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredIndexes.length,
                      itemBuilder: (context, index) {
                        final idx = filteredIndexes[index];
                        return InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print(index);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  OrderDetails(
                                    imageUrl: allImages[index],
                                    price: allPrices[index],
                                    name: allNames[index],
                                    orderid: allorderids[index],
                                    isdelivered: allStatuses[index],
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: Row(
                              children: [
                                if (allImages.length > idx)
                                  Image.network(
                                    allImages[idx] as String,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: InkWell(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allNames[idx] as String,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            '₹${allPrices[idx].toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                allStatuses[idx]
                                                    ? 'Order delivered successfully'
                                                    : 'Order yet to be delivered',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: allStatuses[idx]
                                                      ? FontWeight.bold
                                                      : FontWeight.w600,
                                                  fontSize: 10,
                                                  color: allStatuses[idx]
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
    );
  }
}
