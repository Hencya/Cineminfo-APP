import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/home/home_screen.dart';
import 'package:cineminfo/screen/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Users user;
  const ChangePasswordScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _textFormField(_currentPasswordController, 'Current Password'),
              const SizedBox(
                height: 12,
              ),
              _textFormField(_newPasswordController, 'New Password'),
              const SizedBox(
                height: 12,
              ),
              _textFormField(
                  _confirmPasswordController, 'Confirm New Password'),
              _saveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormField(TextEditingController controller, String title) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
      ),
      textInputAction: TextInputAction.go,
    );
  }

  Widget _saveButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.id)
              .update({
            'password': _newPasswordController.text,
          });
          FirebaseAuth.instance.currentUser!
              .updatePassword(_newPasswordController.text)
              .then((value) => Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (route) => false));
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(hexStringToColor('FFD74B'))),
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ));
  }
}
