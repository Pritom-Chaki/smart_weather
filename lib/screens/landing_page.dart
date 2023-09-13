import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:smart_weather/screens/weather_screens/weather_landing_page.dart';

import 'weather_screens/search_location_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PersistentTabController _controller;
  TextStyle navBtnTextStyle =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger (
      child: Scaffold(
        key: _scaffoldKey,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/images/full_logo.png",
            height: 80,
            width: 150,
          ),
          backgroundColor: Colors.white10,
          actions: [
            IconButton(onPressed: () {
              pushNewScreen(
                context,
                screen: const SearchLocationPage(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );

            }, icon: const   Icon(Icons.search, color: Colors.blue,)),
            IconButton(onPressed: () {}, icon: const   Icon(Icons.notification_important, color: Colors.blue,)),

          ],
        ),
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: false,

          backgroundColor: Colors.white70, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          // decoration: NavBarDecoration(
          //     borderRadius: const BorderRadius.only(
          //         topLeft: Radius.circular(0), topRight: Radius.circular(0)),
          //     colorBehindNavBar: Theme.of(context).colorScheme.background,
          //     boxShadow: [
          //       const BoxShadow(color: Colors.grey, offset: Offset(-1, -1)),
          //     ]),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: false,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle:
              NavBarStyle.style9, // Choose the nav bar style with this property.
          padding: const NavBarPadding.all(0),
          margin: const EdgeInsets.all(0),
          bottomScreenMargin: 50,
          hideNavigationBar: false,
          navBarHeight: 50,
          popAllScreensOnTapAnyTabs: true,
          selectedTabScreenContext: (context) {
            return context;
          },
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const WeatherLandingPage(),
      const WeatherLandingPage(),
      const WeatherLandingPage(),
      const WeatherLandingPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        textStyle: navBtnTextStyle,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.task),
        title: "My Todo",
        textStyle: navBtnTextStyle,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(
      //     Icons.home,
      //     size: 35,
      //   ),
      //   // title: "Search",
      //   activeColorPrimary: Theme.of(context).colorScheme.secondary,
      //   inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      //   activeColorSecondary: Theme.of(context).colorScheme.background,
      //   inactiveColorSecondary: Theme.of(context).colorScheme.background,
      //   textStyle: navBtnTextStyle,
      //   iconSize: 40,
      // ),
      //
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.analytics),
         title: "Analytics",
        textStyle: navBtnTextStyle,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
         title: "Profile",
        textStyle: navBtnTextStyle,
      ),
    ];
  }
}
