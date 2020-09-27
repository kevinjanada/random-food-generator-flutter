import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_food_generator/app_states/food_state.dart';
import 'package:random_food_generator/repositories/food_repository.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class FoodResult extends StatelessWidget {
  Widget build(BuildContext context) {
    FoodState foodState = context.watch<FoodState>();
    Food currFood = foodState.getState();
    bool isLoading = foodState.isLoading;
    Text text;
    Image image;

    if (currFood != null) {
      text = Text(currFood.name, style: TextStyle( fontSize: 20));
      image = Image.asset(currFood.img, height: 200, width: 200);
    } else {
      text = Text("Click on Generate button!", style: TextStyle( fontSize: 20));
      image = Image.asset('images/plate.png', height: 200, width: 200);
    }

    if (isLoading) {
      return CircularProgressIndicator(
        backgroundColor: ORANGE,
        valueColor: new AlwaysStoppedAnimation<Color>(YELLOW),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 4,
          child: image,
        ),
        Expanded(
            flex: 1,
            child: text
        )
      ],
    );
  }
}
