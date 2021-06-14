import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fourth_year_project/Models/Page%20View%20Data.dart';
import 'package:fourth_year_project/Screens/Auth%20Screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../back ground.dart';
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
int _index=0;

  var _controller;
  final List<PageViewData> myData = [
    PageViewData(
        title: 'Find a Restaurant',
        description: "Fastest operation to find a restaurant as you want",
        imageUrl: 'assets/restaurant.png'),
    PageViewData(
        title: 'Pick The Food',
        description: 'Fastest operation to find the best meals',
        imageUrl: 'assets/pizza.png'),
    PageViewData(
        title: 'Get Fastest Delivery',
        description: 'Fastest operation to provide food by the phone',
        imageUrl: 'assets/express-delivery.png'),
  ];
  @override
  void initState() {
    // TODO: implement initState
    _controller= PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_index < 2) {
        _index++;
        _controller.animateToPage(_index,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          BackGroundGradient()
          ,PageView(
            controller: _controller,
            children: [
              _makePage(0),
              _makePage(1),
              _makePage(2),
            ],
            onPageChanged: (index){
              setState(() {
                _index=index;
                if (_index == 2) {
                  Future.delayed(Duration(seconds: 3),
                          () => Navigator.of(context).pushReplacementNamed(Auth_Screen.route_name));
                }
              });
            },
          ),
        Transform.translate(
          offset: Offset(0,height *0.25),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildEveryCircleIndicator(0),
                buildEveryCircleIndicator(1),
                buildEveryCircleIndicator(2),
              ],
            ),
          ),
        ),
          Padding(
            padding:  EdgeInsets.only(bottom: height * 0.03 ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, Auth_Screen.route_name);
                    }
                    ,child: Container(
                        width: width*0.15,
                        height: width*0.15,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue, boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              color: Colors.white,
                              offset: Offset(0, 0))
                        ],
                          borderRadius: BorderRadius.circular(width * 0.08),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size:width*0.08 ,
                        ),
                    ),
                  ),
                  SizedBox(height: height * 0.01,),
                  Text('Skip', style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: width*0.05,
                    fontWeight: FontWeight.w600,
                  ),),
                ],
              ),
            ),
          ),
         ]),
    );

  }
_makeImage(String imageUrl, double percent) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Container(
      width: width,
      height: height * percent,
      decoration: BoxDecoration(
          image: DecorationImage(image: ExactAssetImage(imageUrl))),
    ),
  );
}

_makePage(int pageNumber) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Transform.translate(
    offset: Offset(0,-height * 0.1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _makeImage(myData[pageNumber].imageUrl, 0.4),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          myData[pageNumber].title,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: width * 0.07,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          myData[pageNumber].description,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

buildEveryCircleIndicator(int i) {
  return (i != _index)
      ? Container(
    margin: EdgeInsets.all(4),
    width: 12,
    height: 12,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
  ):Container(
      margin: EdgeInsets.all(4),
      width: 12,
      height: 12,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlue));
}
}
