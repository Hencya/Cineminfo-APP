import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/search/search_tv_screen.dart';
import 'package:cineminfo/screen/tv/tv_widgets.dart';
import 'package:flutter/material.dart';

class TvScreen extends StatefulWidget {
  final Users user;
  const TvScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
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
                        builder: (context) => SearchTvScreen(
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
                      'tv airing today'.toUpperCase(),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                TvAiringTodayScreen(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'tv on the air'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                TvOntheAirWidget(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'tv popular'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                TvPopularWidget(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'tv top rated'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                TvTopRatedWidget(
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
