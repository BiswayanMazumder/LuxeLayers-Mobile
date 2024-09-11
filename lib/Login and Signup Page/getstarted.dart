import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Login%20and%20Signup%20Page/loginpage.dart';
import 'package:luxelayers/Login%20and%20Signup%20Page/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  int _selectedindex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getlanguage();
  }

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
                    _selectedindex == 0
                        ? 'Bringing LuxeLayers Members the best products, inspirations and'
                            ' stories in sports.'
                        : "लक्सलेयर्स के सदस्यों को खेलों में बेहतरीन उत्पाद, प्रेरणा और कहानियाँ लाना।",
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ));
                          },
                          child: Text(
                            _selectedindex == 0 ? 'Join Us' : "हमसे जुड़ें",
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.white, width: 1)),
                          elevation:
                              MaterialStateProperty.all(0), // Remove shadow
                        ),
                        child: Text(
                          _selectedindex == 0 ? 'Sign In' : "साइन",
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
