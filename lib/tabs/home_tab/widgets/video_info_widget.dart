import 'package:flutter/material.dart';

import 'single_video_player.dart';

class VideoInfoWidget extends StatefulWidget {
  final Map<String, String> singleVideoInfo;
  const VideoInfoWidget(this.singleVideoInfo, {Key? key}) : super(key: key);

  @override
  State<VideoInfoWidget> createState() => _VideoInfoWidgetState();
}

class _VideoInfoWidgetState extends State<VideoInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(children: [
        InkWell(
          onTap: () {
            //to do :
            // change it to named route
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SingleVideoPlayer(
                  widget.singleVideoInfo,
                ),
              ),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
              ),
            ),
            //      height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,

            child: Image.network(
              widget.singleVideoInfo['thumbnail'].toString(),
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, _) {
                //a placeholder before image starts to load
                if (frame == null) {
                  return Container(
                    margin: const EdgeInsets.all(50),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey,
                  );
                }
                return child;
              },
              // widget to show while image loads
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.3,
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: deviceHeight * 0.1,
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
          child: Column(
            children: [
              Text(
                widget.singleVideoInfo['speaker'].toString(),
              ),
              Text(
                '${widget.singleVideoInfo['date']} || ${widget.singleVideoInfo['description']}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
