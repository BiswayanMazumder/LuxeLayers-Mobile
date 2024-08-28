import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,color: Colors.black,),
        title: Text('Shop',style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w500,
          fontSize: 18
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap:(){},
                  child: Icon(CupertinoIcons.bag,color: Colors.black,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
