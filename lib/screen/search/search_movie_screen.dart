import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_screen.dart';
import 'package:cineminfo/screen/search/search_movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchMovieScreen extends StatefulWidget {
  final Users user;
  const SearchMovieScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SearchMovieViewModel>(context, listen: false).movies.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchMovieViewModel>(context);
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Search Movie'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                      hintText: 'Movie Title',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                    textInputAction: TextInputAction.go,
                    onChanged: (value) {
                      searchProvider.movies.clear();
                      searchProvider.getMovies(searchController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: body(searchProvider))
        ],
      ),
    );
  }

  Widget body(SearchMovieViewModel viewModel) {
    final isLoading = viewModel.state == SearchMovieViewState.loading;
    final isError = viewModel.state == SearchMovieViewState.error;

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

    return _searchWidget(viewModel);
  }

  Widget _searchWidget(SearchMovieViewModel viewModel) {
    return viewModel.movies.isEmpty
        ? const Center(
            child: Text(
              'No Data',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final movie = viewModel.movies[index];
              return ListTile(
                leading: movie.backdropPath == null
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/noImage.png'),
                                fit: BoxFit.contain)),
                      )
                    : ClipPath(
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                title: Text(
                  movie.title!,
                  style: const TextStyle(color: Colors.white),
                ),
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
              );
            },
            itemCount: viewModel.movies.length);
  }
}
