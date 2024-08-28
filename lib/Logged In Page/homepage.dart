import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List highlightimages = [
    'https://pbs.twimg.com/media/FyDbitjWAAEhh_P.jpg:large',
    'https://marketplace.mainstreet.co.in/cdn/shop/files/v3.webp?v=1724767282&width=823',
    'https://static.nike.com/a/images/w_960,c_limit/6a90b46c-87bb-4882-bce0-f5b856019b78/image.png',
    'https://images.vegnonveg.com/media/collections/102/172007371710266863df57389e.png',
    'https://images.vegnonveg.com/media/collections/75/171955723875667e5c76f082e.png',
    'https://images.vegnonveg.com/media/collections/101/17198391211016682a991ee9b7.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          'Shop',
          style:
              GoogleFonts.nunitoSans(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.bag,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "This Week's Highlights",
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
