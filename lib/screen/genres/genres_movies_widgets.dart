import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/genre/genre_model.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/genres/genre_list_view_model.dart';
import 'package:cineminfo/screen/genres/genres_view_model.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMoviesGenre extends StatefulWidget {
  final Users user;
  final int selectedGenre;
  const ListMoviesGenre({Key? key, this.selectedGenre = 28, required this.user})
      : super(key: key);

  @override
  State<ListMoviesGenre> createState() => _ListMoviesGenreState();
}

class _ListMoviesGenreState extends State<ListMoviesGenre> {
  int? selectedGenre;
  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreViewModel>(context);
    final genreListProvider = Provider.of<GenreListViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Genre genre = genreListProvider.genres[index];
                          selectedGenre = genre.id;
                          genreProvider.getMovieByGenre(selectedGenre!);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: (genreListProvider.genres[index].id ==
                                  selectedGenre)
                              ? Colors.white
                              : Colors.black45,
                        ),
                        child: Text(
                          genreListProvider.genres[index].name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: (genreListProvider.genres[index].id ==
                                    selectedGenre)
                                ? Colors.black45
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const VerticalDivider(
                color: Colors.transparent,
                width: 5,
              ),
              itemCount: genreListProvider.genres.length,
            ),
          ),
        ),
        const SizedBox(height: 10),
        body(genreProvider),
      ],
    );
  }

  Widget body(GenreViewModel viewModel) {
    final isLoading = viewModel.state == GenreViewState.loading;
    final isError = viewModel.state == GenreViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text(
          "Can't get the data",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return _listGenreById(viewModel);
  }

  Widget _listGenreById(GenreViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Movie movie = viewModel.movies[index];
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
                          width: 100,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/noImage.png'),
                                  fit: BoxFit.cover)),
                        )
                      : ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 100,
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
                              width: 100,
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
                  width: 100,
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
          itemCount: viewModel.movies.length,
        ),
      ),
    );
  }
}
