import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/components/drawer_widget.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/main.dart';
import 'package:velocity_x/velocity_x.dart';

import 'discover_screen.dart';
import 'home_screen.dart';
import 'message_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class Home extends StatefulWidget {
  String myUID;
  String partnerUID;
  Home({super.key,required this.myUID,required this.partnerUID});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNavIndex = 0;
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Define the screens for the bottom navigation bar

  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final List<Widget> navScreens = [
      const HomeScreen(),
      const DiscoverScreen(),
      MessageScreen(currentUserUid: widget.myUID!, partnerUid: widget.partnerUID!),
      const ProfileScreen(),
    ];

    // Define the bottom navigation items
    final List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icons/home.svg'),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icons/discover.svg'),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icons/message.svg', width: 22),
        label: 'Message',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icons/profile.svg'),
        label: 'Profile',
      ),
    ];
    final mq = MediaQuery.of(context).size;

    // Define a function to handle bottom navigation bar item selection
    void onNavItemTapped(int index) {
      setState(() {
        currentNavIndex = index;
        // currentScreen = navScreens[index];
        if (index == 3) {
          // If the Profile screen is selected (index 3),
          // navigate directly to the Profile screen.
          pageController.jumpToPage(
            index,
          );
        } else {
          // For other screens, use the PageView to navigate.
          pageController.jumpToPage(
            index,
          );
        }
        // pageController.animateToPage(
        //   index,
        //   duration: const Duration(milliseconds: 200),
        //   curve: Curves.easeInOut,
        // );
      });
    }

    // Exclude the bottom navigation bar on the message screen
    if (currentNavIndex == 2) {
      return WillPopScope(
        onWillPop: () async {
          setState(() {
            currentNavIndex = 0;
          });
          pageController.jumpToPage(
            0,
          );
          return false;
        },
        child: Scaffold(
          body: MessageScreen(
            currentUserUid: widget.myUID!,
            partnerUid: widget.partnerUID!,
          ),
        ),
      );
    }

    // For other screens, show the bottom navigation bar
    return WillPopScope(
      onWillPop: () async {
        if (currentNavIndex != 0) {
          // If not on the home screen, navigate to the home screen and return false
          setState(() {
            currentNavIndex = 0;
          });
          pageController.jumpToPage(
            0,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // Text(
          //     //   'My bunny 🐇',
          //     //   style: TextStyle(
          //     //     fontFamily: 'Univers',
          //     //     fontWeight: FontWeight.w500,
          //     //     fontSize: mq.width * 0.045,
          //     //   ),
          //     // ),
          //     8.widthBox,
          //     SvgPicture.asset('assets/icons/online_indicator.svg'),
          //     8.widthBox,
          //     Text(
          //       'Online',
          //       style: TextStyle(
          //         fontFamily: 'Univers',
          //         fontWeight: FontWeight.w300,
          //         fontSize: mq.width * 0.035,
          //       ),
          //     ),
          // ],
          // ),
          backgroundColor: backgroundColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: darkColor),
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                icon: SvgPicture.asset("assets/icons/drawer/drawer.svg"),
              );
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.back();
                Get.to(() => const NotificationScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 200));
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    "assets/icons/notification.svg",
                    width: 26,
                  ),
                ),
              ),
            )
          ],
        ),
        drawer: customDrawer(),
        body: PageView.builder(
          // pageSnapping: false,
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: navScreens.length,
          // onPageChanged: (index) {
          //   setState(() {
          //     currentNavIndex = index;
          //   });
          // },
          itemBuilder: (context, index) {
            return navScreens[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: navItems,
          currentIndex: currentNavIndex,
          onTap: onNavItemTapped,
          selectedItemColor: whiteColor,
          unselectedItemColor: whiteColor,
          backgroundColor: secondaryColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
