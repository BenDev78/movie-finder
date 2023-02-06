import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_finder/models/movie.dart';
import 'package:movie_finder/repositories/data_repository.dart';
import 'package:movie_finder/ui/widgets/movie/movie_casting.dart';
import 'package:movie_finder/ui/widgets/movie/movie_info.dart';
import 'package:movie_finder/ui/widgets/youtube_video_player.dart';
import 'package:movie_finder/utils/constants.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie movie = await dataProvider.getMovie(movie: widget.movie);

    setState(() {
      newMovie = movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(
                color: kPrimaryColor,
                size: 30,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: newMovie!.videos!.isEmpty
                        ? Center(
                            child: Text(
                              'Pas de vidéo pour ce film',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          )
                        : YoutubeVideoPLayer(
                            videoKey: newMovie!.videos!.first,
                          ),
                  ),
                  MovieInfo(movie: newMovie!),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      newMovie!.description,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  MovieCasting(movie: newMovie!)
                ],
              ),
            ),
    );
  }
}
