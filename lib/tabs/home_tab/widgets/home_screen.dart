import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/home_tab/models/download_data.dart';
import 'package:provider/provider.dart';
import '../models/video_data.dart';
import 'video_info_widget.dart';

class HomeTab extends StatefulWidget {
  // final VideoData videosInfoProvider;
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DownloadData _downloadRef = DownloadData();

//  late Future<void> _initVideoInfoListFuture;
  late Future<List<Map<String, String>>> _videosDataFuture;
  @override
  void initState() {
    // _initVideoInfoListFuture = widget.videosInfoProvider.fetchVideosData();
    _videosDataFuture = _downloadRef.getVideos();
    print(_videosDataFuture.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: FutureBuilder(
        future: _videosDataFuture, //_initVideoInfoListFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  // List<Map<String, String>> videoInfoList =
                  //     Provider.of<VideoData>(context).videosInfo;
                  List<Map<String, String>> VideoDataMap = _downloadRef.dataMap;
                  return GridView.builder(
                    itemCount: VideoDataMap.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 500,
                      childAspectRatio: 3 / 2.1,
                      crossAxisSpacing: 30,
                    ),
                    itemBuilder: ((context, index) => VideoInfoWidget(
                          //  videoInfoList[index],
                          VideoDataMap[index],
                        )),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Error Occurred ! while fetching data...'),
                    ],
                  ),
                );
              }

            default:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Loading ...'),
                    CircularProgressIndicator(),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
