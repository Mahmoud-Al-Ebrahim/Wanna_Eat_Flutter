import 'package:flutter/material.dart';
import 'package:fourth_year_project/Screens/Auth%20Screen.dart';
import 'package:fourth_year_project/back%20ground.dart';

class Top_Meal_Screen extends StatefulWidget {
  static String route_name = '/Top_Meal_Screen';
  @override
  Top_Meal_ScreenState createState() => Top_Meal_ScreenState();
}

class Top_Meal_ScreenState extends State<Top_Meal_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    makeToast('SignUp Successful');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        body: Stack(
          children: [
            BackGroundGradient()
          ],
        ),
      ),
    );
  }
}
