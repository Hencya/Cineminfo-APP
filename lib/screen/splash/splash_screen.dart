import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/actor/actor_popular_view_model.dart';
import 'package:cineminfo/screen/actor/actor_trending_day_view_model.dart';
import 'package:cineminfo/screen/actor/actor_trending_week_view_model.dart';
import 'package:cineminfo/screen/genres/genre_list_view_model.dart';
import 'package:cineminfo/screen/genres/genres_view_model.dart';
import 'package:cineminfo/screen/home/home_screen.dart';
import 'package:cineminfo/screen/movie/movie_now_playing_view_model.dart';
import 'package:cineminfo/screen/movie/movie_popular_view_model.dart';
import 'package:cineminfo/screen/movie/movie_top_rated_view_model.dart';
import 'package:cineminfo/screen/movie/movie_upcoming_view_model.dart';
import 'package:cineminfo/screen/streams/signin_screen.dart';
import 'package:cineminfo/screen/tv/tv_airing_today_view_model.dart';
import 'package:cineminfo/screen/tv/tv_on_the_air_view_model.dart';
import 'package:cineminfo/screen/tv/tv_popular_view_model.dart';
import 'package:cineminfo/screen/tv/tv_top_rated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Users? loggedInUser;

  @override
  void initState() async {
    super.initState();
    if (user == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false);
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = Users.fromMap(value.data());
      //Movies
      Provider.of<NowPlayingViewModel>(context, listen: false)
          .getNowPlayingMovies();
      Provider.of<UpcomingViewModel>(context, listen: false)
          .getUpcomingMovies();
      Provider.of<PopularViewModel>(context, listen: false).getPopularMovies();
      Provider.of<TopRatedViewModel>(context, listen: false)
          .getTopRatedMovies();
      Provider.of<GenreListViewModel>(context, listen: false).getGenreList();
      Provider.of<GenreViewModel>(context, listen: false).getMovieByGenre(28);
      //Tv Shows
      Provider.of<TvAiringViewModel>(context, listen: false).getTvAiring();
      Provider.of<TvOnTheAirViewModel>(context, listen: false).getTvOntheAir();
      Provider.of<TvPopularViewModel>(context, listen: false).getTvPopular();
      Provider.of<TvTopRatedViewModel>(context, listen: false).getTvTopRated();
      //Actor
      Provider.of<ActorDayViewModel>(context, listen: false)
          .getTrendingDayActor();
      Provider.of<ActorWeekViewModel>(context, listen: false)
          .getTrendingWeekActor();
      Provider.of<ActorPopularViewModel>(context, listen: false)
          .getPopularActor();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loggedInUser == null) {
      return Scaffold(
        backgroundColor: hexStringToColor('333333'),
        body: Center(
            child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Cineminfo.png'),
                        fit: BoxFit.cover)))),
      );
    }
    return HomeScreen(
      user: loggedInUser!,
    );
  }
}
