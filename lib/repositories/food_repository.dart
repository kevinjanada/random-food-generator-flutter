import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class Food {
  String name;
  String img;

  factory Food.fromJson(dynamic json) {
    return Food(name: json['name'], img: json['img']);
  }

  Food({ this.name, this.img });

  @override
  String toString() {
    return '{ ${this.name}, ${this.img} }';
  }
}

class FoodRepository {
  Future<List<Food>> get() async {
    String jsonString = await _loadJson();
    List<dynamic> foodsListJson = jsonDecode(jsonString);
    List<Food> foods = foodsListJson.map((foodJson) => Food.fromJson(foodJson)).toList();
    return foods;
  }

  Future<Food> getRandom() async {
    List<Food> foods = await get();
    Random random = new Random();
    int randomNumber = random.nextInt(foods.length);
    return foods.elementAt(randomNumber);
  }

  Future<String> _loadJson() async {
    return await rootBundle.loadString("assets/foods.json");
  }
}