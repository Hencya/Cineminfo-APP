import 'dart:math';

import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/home/home_screen.dart';
import 'package:cineminfo/screen/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    phoneEditingController.dispose();
  }

  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.9)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/Cineminfo.png'),
                              fit: BoxFit.cover)),
                    ),
                    Text(
                      'Cineminfo',
                      style: TextStyle(
                          fontSize: 32, color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                          autofocus: false,
                          controller: nameEditingController,
                          keyboardType: TextInputType.name,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return ("First Name cannot be Empty");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid name(Min. 3 Character)");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              color: Colors.white70,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            label: Text("Name"),
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                          autofocus: false,
                          controller: emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression for email validation
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.white70,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            label: Text("Email"),
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                          autofocus: false,
                          controller: phoneEditingController,
                          keyboardType: TextInputType.phone,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Phone");
                            }
                            // // reg expression for email validation
                            // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            //     .hasMatch(value)) {
                            //   return ("Please Enter a valid email");
                            // }
                            return null;
                          },
                          onSaved: (value) {
                            nameEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.call,
                              color: Colors.white70,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            label: Text("Phone Number"),
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                          autofocus: false,
                          controller: passwordEditingController,
                          obscureText: true,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            nameEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white70,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            label: Text("Password"),
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                          autofocus: false,
                          controller: confirmPasswordEditingController,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          obscureText: true,
                          validator: (value) {
                            if (confirmPasswordEditingController.text !=
                                passwordEditingController.text) {
                              return "Password don't match";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            confirmPasswordEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white70,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            label: Text("Confirm Password"),
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                          )),
                    ),
                    _buttonRegister(),
                  ],
                ),
              ))),
    );
  }

  Widget _buttonRegister() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: ElevatedButton(
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(hexStringToColor('FFD74B'))),
          child: const Text(
            'Register',
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Users userModel = Users();

    userModel.email = user!.email;
    userModel.name = nameEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.id = user.uid;
    userModel.movieFavourite = [];
    userModel.tvFavourite = [];
    userModel.actorFavourite = [];

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    prefs.setString('email', user.email!);
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }
}
