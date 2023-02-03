import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_finder/utils/constants.dart';

class MovieRecommandationText extends StatelessWidget {
  final double voteAverage;
  const MovieRecommandationText({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    Color color = kPrimaryColor;
    int formattedVoteAverage = (voteAverage * 10).toInt();

    if (formattedVoteAverage >= 50 && formattedVoteAverage < 75) {
      color = Colors.orange;
    }

    if (formattedVoteAverage >= 75) {
      color = Colors.green;
    }

    return Text(
      'Recommandé à $formattedVoteAverage%',
      style: GoogleFonts.poppins(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
