import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/cast/cast_list_model.dart';
import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/images/images_model.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/actor%20detail/actor_detail_screen.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_view_model.dart';
import 'package:cineminfo/screen/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final Users user;
  final Movie movie;
  const MovieDetailScreen({Key? key, required this.movie, required this.user})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool readMore = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<DetailMovieViewModel>(context, listen: false)
          .getMovieDetail(widget.movie.id!);
    });
  }

  bool getButton(int id, List movie) {
    bool found = false;
    for (int i = 0; i < movie.length; i++) {
      if (movie[i] == id) {
        found = true;
      }
    }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailMovieViewModel>(context);
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        title: const Text('Detail Film'),
        backgroundColor: hexStringToColor('333333'),
      ),
      body: body(detailProvider),
    );
  }

  Widget body(DetailMovieViewModel viewModel) {
    final isLoading = viewModel.state == DetailMovieViewState.loading;
    final isError = viewModel.state == DetailMovieViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text(
          "Detail Movies is not available",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return _detailMovie(viewModel);
  }

  Widget _detailMovie(DetailMovieViewModel viewModel) {
    return viewModel.movieDetail == null
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        _imageMovie(viewModel),
                        _trailerMovie(viewModel),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                      child: Text(
                        viewModel.movieDetail!.title!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                      child: Text(
                        'Synopis',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        viewModel.movieDetail!.overview!,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.justify,
                        maxLines: readMore ? 10 : 3,
                        overflow: readMore
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              readMore = !readMore;
                            });
                          },
                          child: Text(
                            readMore ? 'read less' : 'read more',
                            style: const TextStyle(color: Colors.orange),
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 8),
                      child: Text(
                        'Genre',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listGenre(viewModel),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Cast',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listActors(viewModel),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Images',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listImages(viewModel),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text(
                        'Similar Movies',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listMovies(viewModel.movieDetail!.similarMovies),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text(
                        'Recomendation Movies',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listMovies(viewModel.movieDetail!.recomendationMovies),
                    getButton(int.parse(viewModel.movieDetail!.id!),
                            widget.user.movieFavourite!)
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    hexStringToColor('FFD74B'),
                                  ),
                                ),
                                child: const Text(
                                  'Added to favourite',
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ),
                            ),
                          )
                        : _buttonFavorite(viewModel),
                  ],
                ),
              ),
            );
          });
  }

  Widget _imageMovie(DetailMovieViewModel viewModel) {
    return viewModel.movieDetail!.backdropPath!.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/noImage.png'),
                    fit: BoxFit.cover)),
          )
        : ClipPath(
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/original/${viewModel.movieDetail!.backdropPath}',
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
          );
  }

  Widget _trailerMovie(DetailMovieViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: GestureDetector(
        onTap: () async {
          Uri youtubeUrl = Uri.parse(
              'https://www.youtube.com/embed/${viewModel.movieDetail!.trailerId}');
          await launchUrl(youtubeUrl);
        },
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.play_circle_outline,
                color: Colors.yellow,
                size: 65,
              ),
              Text(
                'play trailer'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listGenre(DetailMovieViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: Center(
                child: Text(
              viewModel.movieDetail!.genres![index].name,
              style: const TextStyle(color: Colors.white),
            )),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const VerticalDivider(
          color: Colors.transparent,
          width: 12,
        ),
        itemCount: viewModel.movieDetail!.genres!.length,
      ),
    );
  }

  Widget _listActors(DetailMovieViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Container(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Cast cast = viewModel.movieDetail!.castList![index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CastDetailScreen(
                              id: cast.id!,
                              user: widget.user,
                            )));
              },
              child: Column(
                children: [
                  cast.profilePath == null
                      ? const Image(
                          image: AssetImage('assets/images/user.png'),
                          height: 100,
                          width: 100,
                        )
                      : ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                            imageBuilder: (context, imageBuilder) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    image: DecorationImage(
                                      image: imageBuilder,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            },
                            placeholder: (context, url) => Container(
                              width: 100,
                              height: 100,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        cast.name!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: viewModel.movieDetail!.castList!.length,
          separatorBuilder: (BuildContext context, int index) =>
              const VerticalDivider(
            color: Colors.transparent,
            width: 12,
          ),
        ),
      ),
    );
  }

  Widget _listImages(DetailMovieViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Container(
        height: 100,
        child: viewModel.movieDetail!.backdropPath == null
            ? const Image(
                image: AssetImage('assets/images/noImage.png'),
                height: 100,
                width: 100,
              )
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Images image =
                      viewModel.movieDetail!.movieImage.backdrops![index];
                  return Column(
                    children: [
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w200${image.imagePath}',
                          imageBuilder: (context, imageBuilder) {
                            return Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: imageBuilder,
                                fit: BoxFit.cover,
                              )),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 100,
                            height: 100,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: viewModel.movieDetail!.movieImage.backdrops!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const VerticalDivider(
                  color: Colors.transparent,
                  width: 12,
                ),
              ),
      ),
    );
  }

  Widget _buttonFavorite(DetailMovieViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: ElevatedButton(
          onPressed: () {
            List movie = [];
            movie.add(int.parse(viewModel.movieDetail!.id!));
            final docUser = FirebaseFirestore.instance
                .collection('users')
                .doc(widget.user.id);
            docUser.update({"movieFavourite": FieldValue.arrayUnion(movie)});
            Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(hexStringToColor('FFD74B'))),
          child: const Text(
            'Add to favorite',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _listMovies(List<Movie> movies) {
    return movies.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = movies[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                  movie: movie,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                          child: movie.backdropPath == null
                              ? Container(
                                  height: 160,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/noImage.png'),
                                          fit: BoxFit.contain)),
                                )
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 200,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 190,
                                      height: 150,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 200,
                          child: Text(
                            movie.title!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(movie.voteAverage!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const VerticalDivider(
                        color: Colors.transparent,
                        width: 15,
                      ),
                  itemCount: movies.length),
            ),
          );
  }
}
