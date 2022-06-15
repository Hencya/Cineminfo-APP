import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final Users user;
  const AccountScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          photoProfile(context),
          _listData('Nama', user.name!),
          _listData('Email', user.email!),
          _listData('Nomor Telepon', user.phone!),
          _buttonEdit(context),
        ],
      ),
    );
  }

  Widget photoProfile(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.black45),
      child: Image(image: AssetImage('assets/images/user.png')),
    );
  }

  Widget _listData(String title, String data) {
    return ListTile(
      leading: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Text(data, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buttonEdit(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(
              user: user,
            ),
          ),
        );
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(hexStringToColor('FFD74B'))),
      child: const Text(
        'Edit Profile',
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }
}
