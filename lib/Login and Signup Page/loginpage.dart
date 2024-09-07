import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelayers/Logged%20In%20Page/homepage.dart';
import 'package:luxelayers/Navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showpw = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int? _selectedindex;
  void getlanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedindex = prefs.getInt('Language');
    });
    print(_selectedindex);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    _selectedindex == 0 ? 'Welcome Back!' : "फिर से स्वागत है",
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    _selectedindex == 0
                        ? 'Sign in to your account'
                        : "अपने खाते में साइन इन करें",
                    style: GoogleFonts.nunitoSans(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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
                  controller: _emailController,
                  style: GoogleFonts.nunitoSans(),
                  decoration: InputDecoration(
                    hintText: _selectedindex == 0 ? 'Email' : 'ईमेल',
                    border: InputBorder.none, // Remove the default border
                  ),
                ),
              ),
            )),
            const SizedBox(
              height: 30,
            ),
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
                  obscureText: showpw ? false : true,
                  controller: _passwordController,
                  style: GoogleFonts.nunitoSans(),
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showpw = !showpw;
                        });
                      },
                      child: Icon(
                        showpw ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                        color: Colors.black,
                      ),
                    ),
                    hintText: _selectedindex == 0 ? 'Password' : 'पासवर्ड',
                    border: InputBorder.none, // Remove the default border
                  ),
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.65,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (kDebugMode) {
                        print('Tapped');
                      }
                      try {
                        await _auth.sendPasswordResetEmail(
                            email: _emailController.text);
                        if (kDebugMode) {
                          print('sent');
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      _selectedindex == 0
                          ? 'Forgot Password'
                          : "पासवर्ड भूल गए",
                      style: GoogleFonts.nunitoSans(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(),
                      ));
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 58,
                decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  _selectedindex == 0 ? 'Login' : 'लॉगिन',
                  style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
