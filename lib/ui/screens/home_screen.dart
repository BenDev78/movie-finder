import 'package:flutter/material.dart';
import 'package:movie_finder/repositories/data_repository.dart';
import 'package:movie_finder/ui/widgets/movie/movie_card.dart';
import 'package:movie_finder/ui/widgets/movie/movie_category.dart';
import 'package:movie_finder/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.getPopularMovieList();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: [
            SizedBox(
              height: 650,
              child: MovieCard(movie: dataProvider.popularMovieList[0]),
            ),
            MovieCategory(
              label: 'Tendances actuelles',
              movieList: dataProvider.popularMovieList,
              height: 160,
              width: 110,
              callback: dataProvider.getPopularMovieList,
            ),
            MovieCategory(
                label: 'Actuellement au cinéma',
                movieList: dataProvider.nowPlayingMovieList,
                height: 320,
                width: 220,
                callback: dataProvider.getNowPlayingMovieList,
            ),
            MovieCategory(
                label: 'Bientôt disponible',
                movieList: dataProvider.upcomingMovieList,
                height: 160,
                width: 110,
                callback: dataProvider.getUpcomingMovieList,
            ),
          ],
        ),
      ),
    );
  }
}
