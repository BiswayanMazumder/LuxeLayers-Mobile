import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'https://images.vegnonveg.com/media/collections/102/172007371710266863df57389e.png',
    'https://images.vegnonveg.com/media/collections/75/171955723875667e5c76f082e.png',
    'https://images.vegnonveg.com/media/collections/101/17198391211016682a991ee9b7.png',
    // Add more image URLs here
  ];
  List<String> categories = ['All', 'Air Jordan', 'Slides', 'Dunk'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Discover',
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w700, fontSize: 20),
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
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    style: GoogleFonts.nunitoSans(),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: PageView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      imageUrls[index],
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('Clicked');
                      }
                    },
                    child: Text(
                      'See All',
                      style: GoogleFonts.nunitoSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0), // Add 30px space from left
              child: SizedBox(
                height: 50, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Horizontal scroll
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          color: index==0?Colors.green:Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color:index==0?Colors.green: Colors.black)
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
                      )
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
