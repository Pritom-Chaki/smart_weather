
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constant_data.dart';
import '../../utils/local_storage/local_store_manager.dart';
import '../landing_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const routeName = '/on_boarding';
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              //  width: 300,
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 100.0),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: CachedNetworkImageProvider(
                        'https://bridgingapps.org/wp-content/uploads/2023/07/feature-image-1200-%C3%97-550-px-9.png',
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(
            bottom: 80,
          ),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                color: Theme.of(context).colorScheme.background,
                urlImage: 'assets/images/1_welcome.svg',
                title: "We provide professional service at a friendly price",
              ),
              buildPage(
                color: Theme.of(context).colorScheme.background,
                urlImage: 'assets/images/2_create.svg',
                title:
                    'The best result and your satisfaction is our top priority',
              ),
              buildPage(
                color: Theme.of(context).colorScheme.background,
                urlImage: 'assets/images/3_profile.svg',
                title: 'Lets make awesome changes to your home',
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Theme.of(context).colorScheme.background,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              !isLastPage
                  ?   TextButton(
                  onPressed: () => controller.jumpToPage(2),
                  child: Text(
                    "Skip",
                    style: Theme.of(context).textTheme.labelMedium,
                  )): const SizedBox(width: 65,),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(),
                  onDotClicked: (index) => controller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                ),
              ) ,
              isLastPage
                  ? TextButton(
                      onPressed: () async {
                        LocalStorageManager.saveData(
                            AppConstant.onBoarding, false);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LandingPage()));
                      },
                      child: Text(
                        "Start",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.blue),
                      ))
                  : TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text(
                        "Next",
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
