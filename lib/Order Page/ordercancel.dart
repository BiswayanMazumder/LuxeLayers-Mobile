import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrderCancel extends StatefulWidget {
  const OrderCancel({super.key});

  @override
  State<OrderCancel> createState() => _OrderCancelState();
}

class _OrderCancelState extends State<OrderCancel> {
  String? Orderid;
  String? pimg;
  String? pname;
  int? pprice;
  void getorderid()async{
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();
    setState(() {
      Orderid=prefs.getString('Order ID');
      pimg=prefs.getString('Product Image');
      pname=prefs.getString('Product Name');
      pprice=prefs.getInt('Product Price');
    });
    if (kDebugMode) {
      print('Order id $Orderid');
    }
  }
  final List<String> _cancelReasons = [
    'Wrong item ordered',
    'Item arrived damaged',
    'Item was not as described',
    'Found a better price',
    'Changed my mind',
    'Order delayed',
    'Other'
  ];
  String? _selectedReason;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getorderid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
                        children: [
                          Text(
                            pname!,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis, // Adds ellipsis if text overflows
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '₹${pprice!.toString()}',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis, // Adds ellipsis if text overflows
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.network(
                    pimg!,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover, // Ensures the image fits within its container
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                Text('Reason For Cancellation',style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              hint: Text('Select a reason',style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),),
              value: _selectedReason,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedReason = newValue;
                });
                if (kDebugMode) {
                  print(newValue);
                }
              },
              items: _cancelReasons.map((String reason) {
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
