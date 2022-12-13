import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/upload_video_tab/models/upload_data.dart';
import 'package:provider/provider.dart';
import 'tabs/audios_tab/widgets/audio_screen.dart';
import 'tabs/home_tab/widgets/home_screen.dart';
import 'tabs/home_tab/models/video_data.dart';
import 'tabs/profile_tab/models/application_state.dart';
import 'tabs/profile_tab/user_authentication.dart';
import 'tabs/upload_video_tab/upload_main_screen.dart';

enum Tabs {
  home,
  videos,
  upload,
  profile,
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentSelectedTab = Tabs.upload.index;

  List<Widget> listTabs = [
    Consumer<VideoData>(
      builder: (context, videoInfo /*instance of VideoData*/, _) =>
          HomeTab(videoInfo),
    ), //videoTab
    const AudiosTab(),
    // const UploadTab(),
    Consumer<UploadData>(
      builder: (context, uploadData, _) => UploadTab(uploadData),
    ),
    Consumer<ApplicationState>(
      builder: (context, appState, _) => UserAuthentication(appState),
    ), //profile Tab
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: listTabs[currentSelectedTab], // default is home tab

        bottomNavigationBar: BottomNavigationBar(

            // styling from here
            elevation: 20,
            selectedFontSize: 20,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            selectedIconTheme: const IconThemeData(
              size: 35,
            ),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
            unselectedItemColor: Colors.black87,
            backgroundColor: Colors.white,
            // to here
            currentIndex: currentSelectedTab,
            onTap: (int index) {
              setState(
                () {
                  currentSelectedTab = index;
                  // update currentSelectedTab when
                  //user presses different tab
                },
              );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  currentSelectedTab == Tabs.home.index
                      ? Icons.home
                      : Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentSelectedTab == Tabs.videos.index
                      ? Icons.audiotrack_rounded
                      : Icons.audiotrack_outlined,
                ),
                label: 'Audios',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentSelectedTab == Tabs.upload.index
                      ? Icons.info
                      : Icons.info_outline_rounded,
                ),
                label: 'info',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentSelectedTab == Tabs.profile.index
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                ),
                label: 'Profile',
              ),
            ]),
      ),
    );
  }
}
