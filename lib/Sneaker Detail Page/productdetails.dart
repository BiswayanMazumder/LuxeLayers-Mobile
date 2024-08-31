import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Product_Details extends StatefulWidget {
  final String name;
  final String imageUrl;

  const Product_Details({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<Product_Details> createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  bool isliked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    isliked=!isliked;
                  });
                },
                child:  Icon(isliked?Icons.favorite:Icons.favorite_border,
                  color:isliked? Colors.red:Colors.black,),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      body: Column(
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
        ],
      ),
    );
  }
}
