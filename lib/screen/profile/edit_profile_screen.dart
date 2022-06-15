import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/home/home_screen.dart';
import 'package:cineminfo/screen/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final Users user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name!;
    _emailController.text = widget.user.email!;
    _phoneController.text = widget.user.phone!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 0, 8),
                child: Text(
                  'Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              _textFormField(_nameController, 'Name'),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 12, 8),
                child: Text(
                  'Email',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              _textFormField(_emailController, 'Email'),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 12, 8),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              _textFormField(_phoneController, 'Phone'),
              Center(child: _saveButton()),
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
      keyboardType: title == 'Name'
          ? TextInputType.name
          : title == 'Email'
              ? TextInputType.emailAddress
              : TextInputType.phone,
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

  Widget _saveButton() {
    return ElevatedButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.id)
            .update({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text
        });
        FirebaseAuth.instance.currentUser!
            .updateEmail(_emailController.text)
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
      ),
    );
  }
}
