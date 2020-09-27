import 'package:flutter/cupertino.dart';
import 'package:random_food_generator/repositories/food_repository.dart';

class FoodState extends ChangeNotifier {
  Food state;
  bool isLoading = false;

  void setState(Food food) {
    state = food;
    notifyListeners();
  }
  void setIsLoading(bool isLoadingArg) {
    isLoading = isLoadingArg;
    notifyListeners();
  }
  Food getState() {
    return state;
  }
}
