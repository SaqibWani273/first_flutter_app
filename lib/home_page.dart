import 'package:flutter/material.dart';
import 'package:flutter_app/modals/user_authentication.dart';
import 'package:provider/provider.dart';
import 'modals/application_state.dart';
import 'tabs/videos_tab/videos_main_screen.dart';
import 'tabs/home_tab/home_main_screen.dart';
import 'tabs/info_tab/info_main_screen.dart';
import 'tabs/profile_tab/profile_main_screen.dart';

enum Tabs {
  home,
  videos,
  about,
  profile,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSelectedTab = Tabs.profile.index;

  List<Widget> listTabs = [
    HomeTab(),
    VideosTab(),
    InfoTab(),
    Consumer<ApplicationState>(
// will now be able to listen to the changes notified by notifyListeners()
//in ApplicationState

      builder: (context, appState, _) => UserAuthentication(appState),
    ),
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
                  // update currentSelectedTab when user presses different tab
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
                      ? Icons.video_stable_rounded
                      : Icons.video_stable_outlined,
                ),
                label: 'Videos',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentSelectedTab == Tabs.about.index
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