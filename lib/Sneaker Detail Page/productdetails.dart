import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool isliked=false;
  String price='';
  bool isfetched=false;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<void> fetchprice() async{
    final docsnap=await _firestore.collection('sneakers').doc(widget.productid).get();
    if(docsnap.exists){
      setState(() {
        price=docsnap.data()?['Price'];
        isfetched=true;
      });
    }
    if (kDebugMode) {
      print('Price ${price}');
    }
  }
  Future<void> uploadproductimage() async{
    await _firestore.collection('sneakers').doc(widget.productid).update({
      'Product Image':widget.imageUrl
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchprice();
    uploadproductimage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:isfetched? BottomAppBar(
        child: Container(
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('₹$price',style: GoogleFonts.nunitoSans(
                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600
                  ),),
                  const Spacer(),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text('Add To Cart',style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ):const BottomAppBar(
        color: Colors.white,
      ),
      appBar: AppBar(
        actions: [
          Row(
            children: [
            isfetched?  InkWell(
                onTap: (){
                  setState(() {
                    isliked=!isliked;
                  });
                },
                child:  Icon(isliked?Icons.favorite:Icons.favorite_border,
                  color:isliked? Colors.red:Colors.black,),
              ):Container(),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      body:isfetched?SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(widget.imageUrl),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.name,
                style: GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('${widget.name} are versatile footwear designed for comfort and style. '
                  'Originally crafted for athletic use, they have become a staple in '
                  'casual fashion. Available in numerous designs and materials, sneakers'
                  ' blend functionality with trendiness, making them popular for both '
                  'sports and everyday wear. Their enduring appeal lies in their adaptabil'
                  'ity and comfort.',style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w500,
                fontSize: 15
              ),),
            )
          ],
        ),
    ): const Center(
    child: CircularProgressIndicator(
    color: Colors.black,
    )));
  }
}
