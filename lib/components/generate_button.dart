import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_food_generator/app_states/food_state.dart';
import 'package:random_food_generator/repositories/food_repository.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class GenerateButton extends StatelessWidget {
  final FoodRepository _foodRepository = FoodRepository();
  @override
  Widget build(BuildContext context) {
    bool isLoading = context.select<FoodState, bool>((state) => state.isLoading);
    String _text = 'Generate';

    if (isLoading) {
      _text = 'Loading';
    }
    return Column(
        children: [
          ButtonTheme(
            height: 50,
            buttonColor: ORANGE,
            child: RaisedButton(
              onPressed: createGenerateFoodHandler(context),
              child: Text(
                  _text,
                  style: TextStyle( fontSize: 20 )
              ),
            ),
          )
        ]
    );
  }

  Function createGenerateFoodHandler(BuildContext context) {
    var foodState = context.watch<FoodState>();

    if (foodState.isLoading) {
      return () => {};
    }

    void generateFood() async {
      foodState.setIsLoading(true);
      Future.delayed(Duration(seconds: 2)).then((__) async {
        Food food = await _foodRepository.getRandom();
        foodState.setState(food);
        foodState.setIsLoading(false);
      });
    }
    return generateFood;
  }
}
