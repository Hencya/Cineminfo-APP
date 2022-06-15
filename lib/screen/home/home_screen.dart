import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/actor/actor_screen.dart';
import 'package:cineminfo/screen/favourite/favourite_screen.dart';
import 'package:cineminfo/screen/movie/movie_screen.dart';
import 'package:cineminfo/screen/profile/profile_screen.dart';
import 'package:cineminfo/screen/tv/tv_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Users user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: hexStringToColor('333333'),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie_rounded), label: 'Movie'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.tv_rounded), label: 'TV Shows'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group_rounded), label: 'Actors'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded), label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: 'Profile'),
            ]),
        body: currentIndex == 0
            ? MovieScreen(
                user: widget.user,
              )
            : currentIndex == 1
                ? TvScreen(
                    user: widget.user,
                  )
                : currentIndex == 2
                    ? ActorScreen(
                        user: widget.user,
                      )
                    : currentIndex == 3
                        ? FavouriteScreen()
                        : ProfileScreen(
                            user: widget.user,
                          ));
  }
}
