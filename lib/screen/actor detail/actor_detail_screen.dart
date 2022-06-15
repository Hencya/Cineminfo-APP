import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/actor%20detail/actor_detail_view_model.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_screen.dart';
import 'package:cineminfo/screen/splash/splash_screen.dart';
import 'package:cineminfo/screen/tv%20detail/tv_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastDetailScreen extends StatefulWidget {
  final Users user;
  final int id;
  const CastDetailScreen({Key? key, required this.id, required this.user})
      : super(key: key);

  @override
  State<CastDetailScreen> createState() => _CastDetailScreenState();
}

class _CastDetailScreenState extends State<CastDetailScreen> {
  bool readMore = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<DetailCastViewModel>(context, listen: false)
          .getCastDetail(widget.id);
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
    final castDetailProvider = Provider.of<DetailCastViewModel>(context);
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Actor Detail'),
        centerTitle: true,
      ),
      body: body(castDetailProvider),
    );
  }

  Widget body(DetailCastViewModel viewModel) {
    final isLoading = viewModel.state == DetailCastViewState.loading;
    final isError = viewModel.state == DetailCastViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text(
          "Actor detail is not available",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return _detailPerson(viewModel);
  }

  Widget _detailPerson(DetailCastViewModel viewModel) {
    return viewModel.castDetail == null
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _castPhoto(viewModel),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                      child: Text(
                        viewModel.castDetail!.name!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                      child: Text(
                        'Biography',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        viewModel.castDetail!.biography!,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.justify,
                        maxLines: readMore ? 30 : 3,
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
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                      child: Text(
                        'Known in Movies',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listMovies(viewModel.castDetail!.movieCredits!),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                      child: Text(
                        'Known in TVs',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    _listTvs(viewModel.castDetail!.tvCredits!),
                    getButton(int.parse(viewModel.castDetail!.id!),
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

  Widget _castPhoto(DetailCastViewModel viewModel) {
    return viewModel.castDetail!.profilePath == null
        ? Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/user.png'),
                    fit: BoxFit.cover)),
          )
        : Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2,
              child: ClipPath(
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${viewModel.castDetail!.profilePath}',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _listMovies(List<Movie> movies) {
    return movies.isEmpty
        ? const Center(
            child: Text('No movie casting'),
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

  Widget _listTvs(List<TV> tvs) {
    return tvs.isEmpty
        ? const Center(
            child: Text('No TVs casting'),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    TV tv = tvs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TvDetailScreen(
                                  tv: tv,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                          child: tv.backdropPath == null
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
                                        'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
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
                            tv.name!.toUpperCase(),
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
                              Text(tv.voteAverage!,
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
                  itemCount: tvs.length),
            ),
          );
  }

  Widget _buttonFavorite(DetailCastViewModel viewModel) {
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
            movie.add(int.parse(viewModel.castDetail!.id!));
            final docUser = FirebaseFirestore.instance
                .collection('users')
                .doc(widget.user.id);
            docUser.update({"actorFavourite": FieldValue.arrayUnion(movie)});
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
}
