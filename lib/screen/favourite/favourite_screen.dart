import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/cast/cast_detail.dart';
import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/movie/movie_detail.dart';
import 'package:cineminfo/model/tv/tv_detail.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/favourite/actor_favourite_view_model.dart';
import 'package:cineminfo/screen/favourite/movie_favourite_view_model.dart';
import 'package:cineminfo/screen/favourite/tv_favourite_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Users loggedInUser = Users();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = Users.fromMap(value.data());
      setState(() {});
      Provider.of<MovieFavouriteViewModel>(context, listen: false)
          .movieFavourite
          .clear();
      Provider.of<MovieFavouriteViewModel>(context, listen: false)
          .getMovieById(loggedInUser.movieFavourite!);
      Provider.of<TvFavouriteViewModel>(context, listen: false)
          .tvFavourite
          .clear();
      Provider.of<TvFavouriteViewModel>(context, listen: false)
          .getTvById(loggedInUser.tvFavourite!);
      Provider.of<ActorFavouriteViewModel>(context, listen: false)
          .actorFavourite
          .clear();
      Provider.of<ActorFavouriteViewModel>(context, listen: false)
          .getActorById(loggedInUser.actorFavourite!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieFavouriteViewModel>(context);
    final tvProvider = Provider.of<TvFavouriteViewModel>(context);
    final actorProvider = Provider.of<ActorFavouriteViewModel>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: hexStringToColor('333333'),
        appBar: AppBar(
          title: const Text('Favourite'),
          backgroundColor: hexStringToColor('333333'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'TV Shows',
              ),
              Tab(
                text: 'Actors',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            movieFavouriteBody(movieProvider),
            tvFavouriteBody(tvProvider),
            actorFavouriteBody(actorProvider)
          ],
        ),
      ),
    );
  }

  Widget movieFavouriteBody(MovieFavouriteViewModel viewModel) {
    final isLoading = viewModel.state == MovieFavouriteViewState.loading;
    final isError = viewModel.state == MovieFavouriteViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child:
            Text("Can't get the data", style: TextStyle(color: Colors.white)),
      );
    }

    return movieFavouriteWidget(viewModel);
  }

  Widget movieFavouriteWidget(MovieFavouriteViewModel viewModel) {
    return viewModel.movieFavourite.isEmpty
        ? const Center(
            child: Text(
              'there is no favourite movie',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      MovieDetail movie = viewModel.movieFavourite[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: movie.backdropPath == null
                              ? const Image(
                                  image: AssetImage(
                                      'assets/images/noImageDark.png'))
                              : ClipPath(
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                        ),
                        title: Text(
                          movie.title!,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              List movie = [];
                              movie.add(int.parse(
                                  viewModel.movieFavourite[index].id!));
                              final docUser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(loggedInUser.id);
                              docUser.update({
                                "movieFavourite": FieldValue.arrayRemove(movie)
                              });
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user!.uid)
                                    .get()
                                    .then((value) {
                                  loggedInUser = Users.fromMap(value.data());
                                  setState(() {});
                                  Provider.of<MovieFavouriteViewModel>(context,
                                          listen: false)
                                      .movieFavourite
                                      .clear();
                                  Provider.of<MovieFavouriteViewModel>(context,
                                          listen: false)
                                      .getMovieById(
                                          loggedInUser.movieFavourite!);
                                });
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    hexStringToColor('FFD74B'))),
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            )),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const VerticalDivider(),
                    itemCount: viewModel.movieFavourite.length),
              ),
            ],
          );
  }

  Widget tvFavouriteBody(TvFavouriteViewModel viewModel) {
    final isLoading = viewModel.state == TvFavouriteViewState.loading;
    final isError = viewModel.state == TvFavouriteViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child:
            Text("Can't get the data", style: TextStyle(color: Colors.white)),
      );
    }

    return tvFavouriteWidget(viewModel);
  }

  Widget tvFavouriteWidget(TvFavouriteViewModel viewModel) {
    return viewModel.tvFavourite.isEmpty
        ? const Center(
            child: Text(
              'there is no favourite tv shows',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      TvDetail tv = viewModel.tvFavourite[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: tv.backdropPath == null
                              ? const Image(
                                  image: AssetImage(
                                      'assets/images/noImageDark.png'))
                              : ClipPath(
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                        ),
                        title: Text(
                          tv.name!,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              List movie = [];
                              movie.add(
                                  int.parse(viewModel.tvFavourite[index].id!));
                              final docUser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(loggedInUser.id);
                              docUser.update({
                                "tvFavourite": FieldValue.arrayRemove(movie)
                              });
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user!.uid)
                                    .get()
                                    .then((value) {
                                  loggedInUser = Users.fromMap(value.data());
                                  setState(() {});
                                  Provider.of<TvFavouriteViewModel>(context,
                                          listen: false)
                                      .tvFavourite
                                      .clear();
                                  Provider.of<TvFavouriteViewModel>(context,
                                          listen: false)
                                      .getTvById(loggedInUser.movieFavourite!);
                                });
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    hexStringToColor('FFD74B'))),
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            )),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const VerticalDivider(),
                    itemCount: viewModel.tvFavourite.length),
              ),
            ],
          );
  }

  Widget actorFavouriteBody(ActorFavouriteViewModel viewModel) {
    final isLoading = viewModel.state == ActorFavouriteViewState.loading;
    final isError = viewModel.state == ActorFavouriteViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child:
            Text("Can't get the data", style: TextStyle(color: Colors.white)),
      );
    }

    return actorFavouriteWidget(viewModel);
  }

  Widget actorFavouriteWidget(ActorFavouriteViewModel viewModel) {
    return viewModel.actorFavourite.isEmpty
        ? const Center(
            child: Text(
              'there is no favourite actor',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      CastDetail cast = viewModel.actorFavourite[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: cast.profilePath == null
                              ? const Image(
                                  image: AssetImage(
                                      'assets/images/noImageDark.png'))
                              : ClipPath(
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${cast.profilePath}',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                        ),
                        title: Text(
                          cast.name!,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              List movie = [];
                              movie.add(int.parse(
                                  viewModel.actorFavourite[index].id!));
                              final docUser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(loggedInUser.id);
                              docUser.update({
                                "actorFavourite": FieldValue.arrayRemove(movie)
                              });
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user!.uid)
                                    .get()
                                    .then((value) {
                                  loggedInUser = Users.fromMap(value.data());
                                  setState(() {});
                                  Provider.of<ActorFavouriteViewModel>(context,
                                          listen: false)
                                      .actorFavourite
                                      .clear();
                                  Provider.of<ActorFavouriteViewModel>(context,
                                          listen: false)
                                      .getActorById(
                                          loggedInUser.movieFavourite!);
                                });
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    hexStringToColor('FFD74B'))),
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            )),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const VerticalDivider(),
                    itemCount: viewModel.actorFavourite.length),
              ),
            ],
          );
  }
}
