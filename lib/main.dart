import 'package:flutter/material.dart';

import 'Screens/Auth Screen.dart';
import 'Screens/On Boarding Screen.dart';
main()=>runApp(WannaEat());

class WannaEat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider.value(value: OnBoardingProvider(),),
    //
    //   ],
    //   child:
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: OnBoardingScreen() ,
      routes: {
        Auth_Screen.route_name: (context)=>Auth_Screen(),
      },
    );
  }
}