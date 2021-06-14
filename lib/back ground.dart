import 'package:flutter/material.dart';

class BackGroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Colors.orange,
Colors.deepOrange,
Colors.orangeAccent,
Colors.deepOrangeAccent,
Colors.orange,
]
)
),
);
  }
}
