import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: onboarding(),));
}
class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int _currentPage = 0;
  late PageController _pageController;
  List<Slide> _slides = [];

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _slides = [
      Slide("photo/Background.png", "MEET YOUR COACH,\n START YOUR JOURNEY"),
      Slide("photo/p1.png", "CREATE A WORKOUT PLAN\n TO STAY FIT"),
      Slide("photo/p2.png", "ACTIONS  IS THE\n KEY TO ALL SUCCESS"),
    ];
    _pageController = PageController(initialPage: _currentPage);
  }
  Widget _buildSlide(Slide slide, Size size) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage(slide.image), width: size.width * 0.9),
            SizedBox(height: size.height * 0.09),
            Center(
              child: Text(
                slide.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25 * MediaQuery.textScaleFactorOf(context),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        _slides.length,
            (int index) {
          return _buildPageIndicatorItem(index);
        },
      ),
    );
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      height: 5,
      width: _currentPage == index ? 30 : 20,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: index == _currentPage ? Color(0xFF1EA87F) : Color(0xFF3A3A3C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: _slides.map((slide) => _buildSlide(slide,size)).toList(),
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPageIndicator(),
                SizedBox(height: size.height * 0.02),
                _currentPage == 2
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1EA87F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 38,
                      width: size.width * 0.75,
                      child: Center(
                        child: Text(
                          "Start Now",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1EA87F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 38,
                    width: size.width * 0.75,
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
class Slide {
  String image;
  String text;

  Slide(this.image, this.text);
}