import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guardiana/utils/quotes.dart';
import 'package:guardiana/widgets/home_widgets/safewebview.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});
  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: List.generate(
          imageSliders.length,
          (index) => Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
               if (index == 0) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://timesofindia.indiatimes.com/readersblog/scatteredthoughts/womens-empowerment-in-india-from-ancient-period-to-modern-time-period-46689/ "));
                } else if (index == 1) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://plan-international.org/ending-violence/16-ways-end-violence-girls"));
                } else if (index == 2) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
                } else {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.positive.news/society/inspiring-women-who-are-changing-the-world/"));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageSliders[index]),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      articleTitiles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
