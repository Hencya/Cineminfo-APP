import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/color/color_hex.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/actor%20detail/actor_detail_screen.dart';
import 'package:cineminfo/screen/search/search_actor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchActorScreen extends StatefulWidget {
  final Users user;
  const SearchActorScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SearchActorScreen> createState() => _SearchActorScreenState();
}

class _SearchActorScreenState extends State<SearchActorScreen> {
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
    Provider.of<SearchActorViewModel>(context, listen: false).persons.clear();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchActorViewModel>(context);
    return Scaffold(
      backgroundColor: hexStringToColor('333333'),
      appBar: AppBar(
        backgroundColor: hexStringToColor('333333'),
        title: const Text('Search ACtor'),
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
                      hintText: 'Actor Name',
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
                      searchProvider.persons.clear();
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

  Widget body(SearchActorViewModel viewModel) {
    final isLoading = viewModel.state == SearchActorViewState.loading;
    final isError = viewModel.state == SearchActorViewState.error;

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

  Widget _searchWidget(SearchActorViewModel viewModel) {
    return viewModel.persons.isEmpty
        ? const Center(
            child: Text(
              'No Data',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final person = viewModel.persons[index];
              return ListTile(
                leading: person.profilePath == null
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
                                'https://image.tmdb.org/t/p/original/${person.profilePath}',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                title: Text(
                  person.name!,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CastDetailScreen(
                        id: person.id!,
                        user: widget.user,
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: viewModel.persons.length);
  }
}
