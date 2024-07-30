import 'dart:ui';

///import 'package:Seerecs/Assets/data.dart';
import 'package:Seerecs/onboarding/page1.dart';
import 'package:Seerecs/onboarding/page2.dart';
import 'package:Seerecs/onboarding/page3.dart';
import 'package:Seerecs/onboarding/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  var controller = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handlePageChange(int page) {
    setState(() {
      currentPage = page;
    });
  }

  bool _isScrollable(int page) {
    // Enable scrolling only for pages other than page 2
    return page != 3;
  }

  bool _noDot(int page) {
    // Enable scrolling only for pages other than page 2
    return page != 3;
  }

  ///int _activePage = 0;
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    return Padding(
      padding: devicePadding,
      child: Scaffold(
          body: Stack(children: [
            PageView(
              controller: controller,
              physics: _isScrollable(currentPage)
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              //scrollDirection: axisDirectionToAxis(AxisDirection.left),
              onPageChanged: _handlePageChange,
              reverse: false,
              children: [
                PageOne(),
                PageTwo(),
                PageThree(),
                WelcomePage(),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: _noDot(currentPage)
                  ? Container(
                      child: Center(
                        child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: WormEffect(
                              dotColor: Colors.white,
                              activeDotColor: Color(0xFF3C3785),
                              dotWidth: 10,
                              dotHeight: 10,
                            )),
                      ),
                    )
                  : Container(),
            ),
          ])),
    );
  }
}
