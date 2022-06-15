import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/actor/actor_widgets.dart';
import 'package:cineminfo/screen/search/search_actor_screen.dart';
import 'package:flutter/material.dart';

class ActorScreen extends StatefulWidget {
  final Users user;
  const ActorScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Cineminfo'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchActorScreen(
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
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'trending person of the day'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                ActorDayWidget(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'trending person of the week'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                ActorWeekWidget(
                  user: widget.user,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'popular actors'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                ActorPopularWidget(
                  user: widget.user,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
