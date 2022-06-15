import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:cineminfo/model/user/user_model.dart';
import 'package:cineminfo/screen/tv%20detail/tv_detail_screen.dart';
import 'package:cineminfo/screen/tv/tv_airing_today_view_model.dart';
import 'package:cineminfo/screen/tv/tv_on_the_air_view_model.dart';
import 'package:cineminfo/screen/tv/tv_popular_view_model.dart';
import 'package:cineminfo/screen/tv/tv_top_rated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvAiringTodayScreen extends StatefulWidget {
  final Users user;
  const TvAiringTodayScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TvAiringTodayScreen> createState() => _TvAiringTodayScreenState();
}

class _TvAiringTodayScreenState extends State<TvAiringTodayScreen> {
  @override
  Widget build(BuildContext context) {
    final tvAiringProvider = Provider.of<TvAiringViewModel>(context);
    return body(tvAiringProvider);
  }

  Widget body(TvAiringViewModel viewModel) {
    final isLoading = viewModel.state == TvAiringViewState.loading;
    final isError = viewModel.state == TvAiringViewState.error;

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

    return _listTvs(viewModel);
  }

  Widget _listTvs(TvAiringViewModel viewModel) {
    return viewModel.tvAiring.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CarouselSlider.builder(
            itemCount: viewModel.tvAiring.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              TV tv = viewModel.tvAiring[index];
              return GestureDetector(
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
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    tv.backdropPath == null
                        ? Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/noImageDark.jpeg'),
                                    fit: BoxFit.cover)),
                          )
                        : ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        left: 15,
                      ),
                      child: Text(
                        tv.name!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          );
  }
}

class TvOntheAirWidget extends StatefulWidget {
  final Users user;
  const TvOntheAirWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<TvOntheAirWidget> createState() => _TvOntheAirWidgetState();
}

class _TvOntheAirWidgetState extends State<TvOntheAirWidget> {
  @override
  Widget build(BuildContext context) {
    final tvOntheAirProvider = Provider.of<TvOnTheAirViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(tvOntheAirProvider),
      ],
    );
  }

  Widget body(TvOnTheAirViewModel viewModel) {
    final isLoading = viewModel.state == TvOnTheAirViewState.loading;
    final isError = viewModel.state == TvOnTheAirViewState.error;

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

    return _listTvs(viewModel);
  }

  Widget _listTvs(TvOnTheAirViewModel viewModel) {
    return viewModel.tvOnTheAir.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    TV tv = viewModel.tvOnTheAir[index];
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
                                  width: 100,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/noImage.png'),
                                          fit: BoxFit.cover)),
                                )
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
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
                  itemCount: viewModel.tvOnTheAir.length),
            ),
          );
  }
}

class TvPopularWidget extends StatefulWidget {
  final Users user;
  const TvPopularWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<TvPopularWidget> createState() => _TvPopularWidgetState();
}

class _TvPopularWidgetState extends State<TvPopularWidget> {
  @override
  Widget build(BuildContext context) {
    final tvPopularProvider = Provider.of<TvPopularViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(tvPopularProvider),
      ],
    );
  }

  Widget body(TvPopularViewModel viewModel) {
    final isLoading = viewModel.state == TvPopularViewState.loading;
    final isError = viewModel.state == TvPopularViewState.error;

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

    return _listTvs(viewModel);
  }

  Widget _listTvs(TvPopularViewModel viewModel) {
    return viewModel.tvPopular.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    TV tv = viewModel.tvPopular[index];
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
                                  width: 100,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/noImage.png'),
                                          fit: BoxFit.cover)),
                                )
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
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
                  itemCount: viewModel.tvPopular.length),
            ),
          );
  }
}

class TvTopRatedWidget extends StatefulWidget {
  final Users user;
  const TvTopRatedWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<TvTopRatedWidget> createState() => _TvTopRatedWidgetState();
}

class _TvTopRatedWidgetState extends State<TvTopRatedWidget> {
  @override
  Widget build(BuildContext context) {
    final tvTopRatedProvider = Provider.of<TvTopRatedViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(tvTopRatedProvider),
      ],
    );
  }

  Widget body(TvTopRatedViewModel viewModel) {
    final isLoading = viewModel.state == TvTopRatedViewState.loading;
    final isError = viewModel.state == TvTopRatedViewState.error;

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

    return _listTvs(viewModel);
  }

  Widget _listTvs(TvTopRatedViewModel viewModel) {
    return viewModel.tvTopRated.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    TV tv = viewModel.tvTopRated[index];
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
                                  width: 100,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/noImage.png'),
                                          fit: BoxFit.cover)),
                                )
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${tv.backdropPath}',
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
                  itemCount: viewModel.tvTopRated.length),
            ),
          );
  }
}
