import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayer extends StatefulWidget {
  final Map<String, String> videoIfnoList;

  const SingleVideoPlayer(this.videoIfnoList, {Key? key}) : super(key: key);

  @override
  State<SingleVideoPlayer> createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
//  static const routename = '/singleVideoPlayer';
  late final String videoDescription;
  late final String videoDate;
  late final String videoSpeaker;
  bool videoHovered = false;
  late VideoPlayerController _video;
  late Future<void> _initVideoFuture;
  String temp = 'first';
//to store the Future returned from VideoPlayerController.initialize

  @override
  void initState() {
    final String videoUrl = widget.videoIfnoList['url'].toString();

    videoDescription = widget.videoIfnoList['description'].toString();
    videoDate = widget.videoIfnoList['date'].toString();
    videoSpeaker = widget.videoIfnoList['speaker'].toString();
    _video = VideoPlayerController.network(videoUrl);
    _initVideoFuture = _video.initialize();
    // initializes the video
    _video.setLooping(true);
    // Use the controller to loop the video.
    super.initState();
  }

  @override
  void dispose() {
    _video.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.

    return Scaffold(
      body: FutureBuilder(
        future: _initVideoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (temp == 'first') {
              _video.play();
              temp = 'second';
            }

            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Center(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: _video.value.aspectRatio,
                    child: MouseRegion(
                      onExit: ((event) {
                        // print('hover removed');
                        setState(() {
                          videoHovered = false;
                        });
                      }),
                      onHover: (event) {
                        //  print('hovered');
                        setState(() {
                          videoHovered = true;
                        });
                      },
                      child: InkWell(
                        onDoubleTap: () {
                          print(' tapped');
                          setState(() {
                            // If the video is playing, pause it.
                            if (_video.value.isPlaying) {
                              print('playing');
                              _video.pause();
                            } else {
                              // If the video is paused, play it.
                              _video.play();
                            }
                          });
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              VideoPlayer(_video),
                              // Use the VideoPlayer widget to display the video.
                              VideoProgressIndicator(
                                _video,
                                allowScrubbing: true,
                                padding: const EdgeInsets.all(8.0),
                                colors: VideoProgressColors(
                                  playedColor: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          // if (!_video.value.isPlaying)
                          //   ElevatedButton.icon(
                          //     onPressed: () {
                          //       setState(() {
                          //         _video.play();
                          //       });
                          //     },
                          //     icon: Icon(Icons.play_arrow_rounded),
                          //     label: const Text('play'),
                          //   )
                          if (videoHovered)
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  // If the video is playing, pause it.
                                  if (_video.value.isPlaying) {
                                    _video.pause();
                                  } else {
                                    // If the video is paused, play it.
                                    _video.play();
                                  }
                                });
                              },
                              icon: Icon(
                                _video.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              label: _video.value.isPlaying
                                  ? const Text('pause')
                                  : const Text('play'),
                            ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Column(
                    children: [
                      Text(videoSpeaker),
                      Text('$videoDate || $videoDescription'),
                    ],
                  )),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 250,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
