import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayer extends StatefulWidget {
  final Map<String, String> videoInfoList;

  const SingleVideoPlayer(this.videoInfoList, {Key? key}) : super(key: key);

  @override
  State<SingleVideoPlayer> createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
//  static const routename = '/singleVideoPlayer';
  late final String videoDescription;
  late final String videoDate;
  late final String videoSpeaker;
  late final String videoUrl;
  late VideoPlayerController _video;
  late Future<void> _initVideoFuture;

  @override
  void initState() {
    videoUrl = widget.videoInfoList['videoUrl']!;
    videoDescription = widget.videoInfoList['description']!;
    videoDate = widget.videoInfoList['date']!;
    videoSpeaker = widget.videoInfoList['speaker']!;
    _video = VideoPlayerController.network(videoUrl);
    _initVideoFuture = _video.initialize();

    // initializes the video
    _video.setLooping(true);
    // Use the controller to loop the video.

    _video.play();
    //automatically play video for the first time
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
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Center(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: _video.value.aspectRatio,
                    child: InkWell(
                      onTap: () {
                        // onTap was not work without using IgnorePointer
                        setState(() {
                          // If the video is playing, pause it.
                          _video.value.isPlaying
                              ? _video.pause()
                              : _video.play();
                        });
                      },
                      child: IgnorePointer(
                        // to make onTap() work
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
                          if (!_video.value.isPlaying)
                            ElevatedButton.icon(
                              onPressed: () {
                                // setState(() {
                                //   _video.play();
                                // });
                              },
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: const Text('play'),
                            )
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text(videoSpeaker),
                      Text('$videoDate || $videoDescription'),
                    ],
                  ),
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
