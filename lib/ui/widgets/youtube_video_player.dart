import 'package:flutter/material.dart';
import 'package:movie_finder/utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPLayer extends StatefulWidget {
  final String videoKey;
  const YoutubeVideoPLayer({super.key, required this.videoKey});

  @override
  State<YoutubeVideoPLayer> createState() => _YoutubeVideoPLayerState();
}

class _YoutubeVideoPLayerState extends State<YoutubeVideoPLayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      progressColors: ProgressBarColors(
          handleColor: kPrimaryColor,
          playedColor: kPrimaryColor,
          backgroundColor: kPrimaryColor.withOpacity(.3)),
      onEnded: (YoutubeMetaData meta) {
        _controller.play();
        _controller.pause();
      },
    );
  }
}
