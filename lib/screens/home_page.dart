import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final house = ModalRoute.of(context)!.settings.arguments as String;
    final backgroundImage = {
      "gryffindor": "assets/g_dorm.webp",
      "ravenclaw": "assets/r_dorm.webp",
      "slytherin": "assets/s_dorm.webp",
      "hufflepuff": "assets/h_dorm.webp",
    }[house];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
