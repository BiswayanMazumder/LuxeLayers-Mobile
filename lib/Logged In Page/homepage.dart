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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Discover',
          style:
              GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, fontSize: 20),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          10.0), // Add padding to prevent the TextField from touching the container's border
                  child: TextField(
                    style: GoogleFonts.nunitoSans(),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: 'Search',
                      border: InputBorder.none, // Remove the default border
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200, // Fixed height for the PageView
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
                    onTap: (){
                      if (kDebugMode) {
                        print('CLicked');
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
            )
          ],
        ),
      ),
    );
  }
}
