import 'package:flutter/material.dart';
import 'package:random_food_generator/repositories/food_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_states/food_state.dart';
import 'components/food_result.dart';
import 'package:provider/provider.dart';
import 'components/generate_button.dart';
import 'components/header.dart';
import 'colors.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FoodState(),
      child: App(),
    )
  );
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return (
        MaterialApp(
            home: Scaffold(
                body: Container(
                    color: YELLOW,
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [ Header(text: "Random Food Generator") ]
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                                alignment: Alignment.center,
                                child: FoodResult(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [ GenerateButton(), ]
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [ FindInGoogleMapsButton() ],
                            ),
                          ),
                          Expanded( // TODO: Admob thingy
                            flex: 2,
                            child: Row(),
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}

class FindInGoogleMapsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodState foodState = context.watch<FoodState>();
    Food food = foodState.getState();

    if (foodState.getState() == null || foodState.isLoading) {
      return Row();
    }

    String foodName = food.name;
    return RaisedButton.icon(
      icon: Icon(Icons.pin_drop),
      label: Text("Find $foodName"),
      onPressed: () => launchMapsUrl(foodName),
    );
  }

  void launchMapsUrl(String foodName) async {
    String urlEncodedFoodName = Uri.encodeQueryComponent(foodName);
    // https://www.google.com/maps/search/?api=1&query=nasi+goreng
    final url = 'https://www.google.com/maps/search/?api=1&query=$urlEncodedFoodName';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
