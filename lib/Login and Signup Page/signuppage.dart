import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  bool showpw=false;
  final FirebaseAuth _auth=FirebaseAuth.instance;
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
                  Text('Sign Up',style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),
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
                  child: Text('Create your account so that you can \nquickly order your favourite sneakers',style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding to prevent the TextField from touching the container's border
                    child: TextField(
                      controller: _nameController,
                      style: GoogleFonts.nunitoSans(),
                      decoration: const InputDecoration(
                        hintText: 'User Name',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                )
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding to prevent the TextField from touching the container's border
                    child: TextField(
                      controller: _emailController,
                      style: GoogleFonts.nunitoSans(),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                )
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding to prevent the TextField from touching the container's border
                    child: TextField(
                      obscureText: showpw?false:true,
                      controller: _passwordController,
                      style: GoogleFonts.nunitoSans(),
                      decoration:  InputDecoration(
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              showpw=!showpw;
                            });
                          },
                          child: Icon(showpw?CupertinoIcons.eye_slash:CupertinoIcons.eye
                            ,color: Colors.black,),
                        ),
                        hintText: 'Password',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                )
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: ()async{
                try{
                  await _auth.signInWithEmailAndPassword(email: _emailController.text,
                      password: _passwordController.text);
                }catch(e){
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
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Center(child: Text('Register Now',style: GoogleFonts.nunitoSans(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
