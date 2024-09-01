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
      'Product Image':widget.imageUrl,
      'UK 6':true,
      'UK 7':false,
      'UK 8':true,
      'UK 9':true,
      'UK 10':false,
      'UK 11':true,
      'UK 12':false
    });
  }
  bool isuk6=false;
  bool isuk7=false;
  bool isuk8=false;
  bool isuk9=false;
  bool isuk10=false;
  bool isuk11=false;
  bool isuk12=false;
  List<String> categories = [
    // 'UK 6',
    // // 'UK 6.5',
    // 'UK 7',
    // // 'UK 7.5',
    // 'UK 8',
    // 'UK 9',
    // 'UK 10',
    // 'UK 11',
    // 'UK 12'
  ];
  Future<void> fetchshoesizes() async{
    final docsnap=await _firestore.collection('sneakers').doc(widget.productid).get();
    if(docsnap.exists){
      setState(() {
        isuk6=docsnap.data()?['UK 6'];
        if(isuk6){
          categories.add('UK 6');
        }
        isuk7=docsnap.data()?['UK 7'];
        if(isuk7){
          categories.add('UK 7');
        }
        isuk8=docsnap.data()?['UK 8'];
        if(isuk8){
          categories.add('UK 8');
        }
        isuk9=docsnap.data()?['UK 9'];
        if(isuk9){
          categories.add('UK 9');
        }
        isuk10=docsnap.data()?['UK 10'];
        if(isuk10){
          categories.add('UK 10');
        }
        isuk11=docsnap.data()?['UK 11'];
        if(isuk11){
          categories.add('UK 11');
        }
        isuk12=docsnap.data()?['UK 12'];
        if(isuk12){
          categories.add('UK 12');
        }
        isfetched=true;
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
  }

  int _selectedIndex = 0;
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
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Select Size',style: GoogleFonts.nunitoSans(),),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 5.0,right: 5.0), // Add 30px space from left
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
                            _selectedIndex = index; // Update the selected index
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 80,
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
              height: 20,
            ),
          ],
        ),
    ): const Center(
    child: CircularProgressIndicator(
    color: Colors.black,
    )));
  }
}
