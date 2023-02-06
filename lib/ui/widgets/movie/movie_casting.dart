import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_finder/models/movie.dart';
import 'package:movie_finder/ui/widgets/actor/actor_card.dart';

class MovieCasting extends StatelessWidget {
  final Movie movie;
  const MovieCasting({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Casting',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.casting!.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 160,
                child: movie.casting![index].profilePath == null
                    ? Center(
                        child: Text(
                        "Pas d'image",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ))
                    : ActorCard(actor: movie.casting![index]),
              );
            },
          ),
        )
      ],
    );
  }
}
