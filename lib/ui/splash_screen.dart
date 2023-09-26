import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:foodie/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;
  SwiperController swiperController = SwiperController();
  List<Map> cards = [
    {"header": "Order Your Food", "description": "Now you can order your food any time right from your mobile", "image": "assets/images/order.png"},
    {"header": "Cooking Safe Food", "description": "We are maintain safty and We keep clean while making food", "image": "assets/images/cooking.png"},
    {"header": "Quick Delivery", "description": "Orders your favorite meals will be immediately deliver", "image": "assets/images/delivery.png"}
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex == 0
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              currentIndex = currentIndex - 1;
                              swiperController.previous();
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                          )),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                    child: Text("Skip", style: TextStyle(color: Colors.grey[600])),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                // width: screenWidth,
                padding: const EdgeInsets.all(20.0),
                height: screenHeight * 0.65,
                child: Swiper(
                  loop: false,
                  controller: swiperController,
                  index: currentIndex,
                  onIndexChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, currentIndex) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        currentIndex % 2 == 0
                            ? Container(
                                margin: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cards[currentIndex]['header'],
                                      style: TextStyle(color: appThemeColor, fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(cards[currentIndex]['description'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: screenHeight * 0.02)),
                                  ],
                                ),
                              )
                            : Container(),
                        Image.asset(
                          cards[currentIndex]['image'],
                          fit: BoxFit.cover,
                        ),
                        currentIndex % 2 != 0
                            ? Container(
                                margin: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cards[currentIndex]['header'],
                                      style: TextStyle(color: appThemeColor, fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(cards[currentIndex]['description'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: screenHeight * 0.02)),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 3.0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: cards.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.circle,
                                size: 8.0,
                                color: currentIndex == index ? appThemeColor : Colors.grey,
                              ),
                            );
                          }),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (currentIndex < cards.length - 1) {
                          setState(() {
                            currentIndex = currentIndex + 1;
                            swiperController.next();
                          });
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appThemeColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                      child: Text(currentIndex == 2 ? 'Start' : 'Next', style: const TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
