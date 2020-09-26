import 'package:flutter/material.dart';
import 'food_repository.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
          color: Color.fromRGBO(252, 166, 82, 1.0),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ Header(text: "Random Food Generator") ]
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ GenerateButton(), ]
                  ),
                ),
                Expanded(
                  child: Row(),
                ),
              ]
          )
      )
    )
  ));
}

class Header extends StatelessWidget {
  final String text;

  Header({ this.text });

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 36,
        fontFamily: "Roboto Slab",
        fontWeight: FontWeight.bold,
      )
    );
  }
}


class GenerateButton extends StatelessWidget {
  FoodRepository _foodRepository = FoodRepository();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedCircularButton(onPressed: generateFood),
        Header(text: "Generate!"),
      ]
    );
  }

  void generateFood() async {
    Food food = await _foodRepository.getRandom();
    print(food.toString());
  }
}

class RaisedCircularButton extends StatelessWidget {
  final Function onPressed;
  RaisedCircularButton({ this.onPressed });
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 120.0,
      minWidth: 120.0,
      child: RaisedButton(
        shape: CircleBorder(),
        onPressed: onPressed,
        color: Color.fromRGBO(172, 75, 28, 1.0),
      ),
    );
  }
}
