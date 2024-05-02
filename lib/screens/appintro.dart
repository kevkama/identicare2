import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:identicare2/components/my_button.dart';
import 'package:lottie/lottie.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  IntroState createState() => IntroState();
}

class IntroState extends State<Intro> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Stack(
        children: [
          Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    setState(() {
                    });
                  },
                ),
                items: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 500,
                          child: Lottie.asset(
                            'assets/images/intro1.json',
                            key: UniqueKey(),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Text(
                          "Isn't is unfortunate how healthcare information is limited",
                          style: TextStyle(
                            color: Color(0xff97FB57),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 500,
                          child: Lottie.asset(
                            'assets/images/intro2.json',
                            key: UniqueKey(),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Text(
                          'With Identicare you can learn more from other peoples experiences',
                          style: TextStyle(
                            color: Color(0xff97FB57),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 500,
                          child: Lottie.asset(
                            'assets/images/intro3.json',
                            key: UniqueKey(),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Text(
                          'Take controle of the care you get',
                          style: TextStyle(
                            color: Color(0xff97FB57),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyButton(
                text: 'Get Started',
                onTap: () {
                  Navigator.pushNamed(context, '/loginOrSignUp');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}