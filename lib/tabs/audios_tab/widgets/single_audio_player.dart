import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audio_manager/audio_manager.dart';

class SingleAudioPlayer extends StatefulWidget {
  final Map<String, String> currentAudioInfo;

  const SingleAudioPlayer(this.currentAudioInfo, {Key? key}) : super(key: key);

  @override
  State<SingleAudioPlayer> createState() => _SingleAudioPlayerState();
}

class _SingleAudioPlayerState extends State<SingleAudioPlayer> {
  final AudioPlayer myAudioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration audioDuration = Duration.zero;
  Duration audioPosition = Duration.zero;
  late Source audioUrl;
  // to format duration nicely
  formatDuration(duaration) {
    return duaration.toString().split('.').first.padLeft(8, "0");
  }

  @override
  void initState() {
    audioUrl = UrlSource(widget.currentAudioInfo['audioUrl'].toString());

    startAudio(); //auto start audio for the first time

    // listen to events : playing,paused...
    myAudioPlayer.onPlayerStateChanged.listen(
      (event) {
        // using mounted will call setstate only if the widget is in tree
        // i.e. after state is created and untill disposed
        if (mounted)
          setState(() {
            isPlaying = event == PlayerState.playing;
          });
      },
    );
// lsiten to audio duration
    myAudioPlayer.onDurationChanged.listen(
      (newDuration) {
        if (mounted)
          setState(() {
            audioDuration = newDuration;
          });
      },
    );

    // listen to audio position
    myAudioPlayer.onPositionChanged.listen(
      (newPosition) {
        if (mounted)
          setState(() {
            audioPosition = newPosition;
          });
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    myAudioPlayer.dispose();
    super.dispose();
  }

  Future startAudio() async {
    await myAudioPlayer.play(audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.currentAudioInfo['audioPicture'].toString(),
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, _) {
                //a placeholder before image starts to load
                if (frame == null) {
                  return Container(
                    margin: const EdgeInsets.all(50),
                    height: 200,
                    width: 300,
                    color: Colors.blue,
                  );
                }
                return child;
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  height: 300,
                  width: 300,
                  child: Center(
                      child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  )),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(widget.currentAudioInfo['title'].toString()),
            SizedBox(
              height: 4,
            ),
            Text("${widget.currentAudioInfo['speaker']}"),
            Slider(
              min: 0,
              max: audioDuration.inSeconds.toDouble(),
              value: audioPosition.inSeconds.toDouble(),
              onChanged: (valueInDouble) async {
                final position = Duration(seconds: valueInDouble.toInt());

                await myAudioPlayer.seek(position);
              },
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(audioPosition)),
                  Text(formatDuration(audioDuration)),
                  // Text(formatDuration(audioDuration - audioPosition)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await myAudioPlayer.pause();
                  } else {
                    myAudioPlayer.resume();
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
