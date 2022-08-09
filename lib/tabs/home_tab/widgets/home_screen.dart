import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/video_data.dart';
import 'video_info_widget.dart';

class HomeTab extends StatefulWidget {
  final VideoData videosInfoProvider;
  const HomeTab(this.videosInfoProvider, {Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<void> _initVideoInfoListFuture;
  @override
  void initState() {
    _initVideoInfoListFuture = widget.videosInfoProvider.fetchVideosData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initVideoInfoListFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  List<Map<String, String>> videoInfoList =
                      Provider.of<VideoData>(context).videosInfo;
                  return GridView.builder(
                    itemCount: videoInfoList.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 500,
                      childAspectRatio: 3 / 2.3,
                      crossAxisSpacing: 30,
                    ),
                    itemBuilder: ((context, index) => VideoInfoWidget(
                          videoInfoList[index],
                        )),
                  );
                }
                return Center(
                  child: Column(
                    children: const [
                      Text('Loading ...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }

            default:
              return Center(
                child: Column(
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
