import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/genres/genres_movies_widgets.dart';
import 'package:cineminfo/screen/movie/movie_widgets.dart';
import 'package:cineminfo/screen/search/search_movie_screen.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  final Users user;
  const MovieScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        title: const Text('Cineminfo'),
        backgroundColor: hexStringToColor('333333'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchMovieScreen(
                              user: widget.user,
                            )));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      'now playing movies'.toUpperCase(),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                NowPlayingWidgets(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'genres'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                ListMoviesGenre(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'Popular movies'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                PopularWidgets(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'top rated movies'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                TopRatedWidgets(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'upcoming movie'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                UpcomingWidgets(
                  user: widget.user,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
