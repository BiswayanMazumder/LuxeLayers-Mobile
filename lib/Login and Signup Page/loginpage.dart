import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.network(
              'https://images.pexels.com/photos/18202576/pexels-photo-18202576/f'
              'ree-photo-of-person-wearing-white-green-trainers-and-green-jeans.jpeg?auto=compress&cs=tinysrgb&w=600',
              fit: BoxFit.cover,
            ),
          ),
          // Text at the bottom of the screen
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bringing LuxeLayers Members the best products, inspirations and stories in sports.',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Join Us',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.white, width: 1)),
                          elevation:
                              MaterialStateProperty.all(0), // Remove shadow
                        ),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
