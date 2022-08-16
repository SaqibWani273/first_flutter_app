import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/audios_tab/widgets/single_audio_player.dart';
//import 'package:universal_html/html.dart';
import '../models/audios_description.dart';

class AudiosTab extends StatefulWidget {
  const AudiosTab({Key? key}) : super(key: key);

  @override
  State<AudiosTab> createState() => _AudiosTabState();
}

class _AudiosTabState extends State<AudiosTab> {
  late Future<void> initAudioDetails;
  AudioDescription audios = AudioDescription();

  @override
  void initState() {
    initAudioDetails = audios.fetchAudioDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home tab'),
        ),
        body: FutureBuilder(
          future: initAudioDetails,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasData) {
                    List<Map<String, String>> audioInfoList = audios.audiosInfo;
                    return Center(
                        child: ListView.builder(
                      itemCount: audioInfoList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Text('${index + 1}.'),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 100,
                                    child: Text(audioInfoList[index]['title']
                                        .toString()),
                                  ),
                                  title: Text(audioInfoList[index]['speaker']
                                      .toString()),
                                  subtitle: const Text("30:00"),
                                  trailing: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              SingleAudioPlayer(
                                                  audioInfoList[index]),
                                        ));
                                      },
                                      child: Column(
                                        children: [
                                          Text('play'),
                                          Icon(Icons.play_arrow_rounded),
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ));
                  }
                  return const Center(
                    child: Text('snapshot has no data'),
                  );
                }

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}
