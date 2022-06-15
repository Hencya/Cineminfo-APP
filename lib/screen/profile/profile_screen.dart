import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/profile/account_screen.dart';
import 'package:cineminfo/screen/profile/change_password_screen.dart';
import 'package:cineminfo/screen/streams/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final Users user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Account',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountScreen(
                        user: widget.user,
                      ),
                    ),
                  );
                },
                tileColor: Colors.black45,
              ),
              ListTile(
                title: const Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(
                        user: widget.user,
                      ),
                    ),
                  );
                },
                tileColor: Colors.black45,
              ),
              ListTile(
                title: const Text(
                  'App Version',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Text(
                  '6.9.420',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
                tileColor: Colors.black45,
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  FirebaseAuth.instance.signOut().then((value) {
                    prefs.remove('email');
                    Navigator.pushAndRemoveUntil(
                        (context),
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                        (route) => false);
                  });
                },
                tileColor: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
