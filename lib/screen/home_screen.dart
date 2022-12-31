import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/provider/user_provider.dart';
import 'package:live_streaming_pro_2/screen/feed_screen.dart';
import 'package:live_streaming_pro_2/screen/go_live_screen.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homepage";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages=[
    const FeedScreen(),
    const GoLiveScreen(),
    const Center(child: Text("Browser"),)
  ];

  int _currentPage = 0;
  void onChangePage(int page) {
    _currentPage = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        unselectedFontSize: 12,
        onTap: onChangePage,
        currentIndex: _currentPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Following"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_rounded), label: "Go Live"),
          BottomNavigationBarItem(icon: Icon(Icons.copy), label: "Browser"),
        ],
      ),
      body: pages[_currentPage],
    );
  }
}
