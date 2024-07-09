import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/components/button.dart';
import 'package:testing/core/components/dot_indicators.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/core/utils/routes.dart';
import 'package:testing/presentation/privider/onboard/notifier.dart';

import 'widgets/onboard.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(builder: (context, notifier, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: notifier.pageController,
                    itemCount: notifier.onboardData.length,
                    onPageChanged: (value) {
                      notifier.pageIndex = value;
                    },
                    itemBuilder: (context, index) => OnBoardingWidget(
                        title: notifier.onboardData[index].title,
                        description: notifier.onboardData[index].description,
                        image: notifier.onboardData[index].image),
                  ),
                ),
                SizedBox(
                  height: kToolbarHeight * 2,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          notifier.onboardData.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 16.0 / 4),
                            child:
                                DotIndicator(isActive: index == notifier.pageIndex),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    buttonColor(context,onPressed: () {
                      if (notifier.pageIndex < notifier.onboardData.length - 1) {
                        notifier.pageController!.nextPage(duration: defaultDuration, curve: Curves.ease);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.userlist, (route) => false);
                      }
                    }, label: ((notifier.pageIndex < notifier.onboardData.length - 1)? 'Next' : 'Get Started').toUpperCase()),
                    
                    Visibility(
                      visible: (notifier.pageIndex < notifier.onboardData.length - 1),
                      child: buttonText(context, onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Routes.userlist, (route) => false), label: 'Skip'),
                    ),
                    Visibility(
                      visible: !(notifier.pageIndex < notifier.onboardData.length - 1),
                      child: const SizedBox(
                        height: kBottomNavigationBarHeight,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
