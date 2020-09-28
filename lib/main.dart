import 'package:flutter/material.dart';
import 'package:random_food_generator/repositories/food_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'ad_manager.dart';
import 'app_states/food_state.dart';
import 'components/food_result.dart';
import 'package:provider/provider.dart';
import 'components/generate_button.dart';
import 'components/header.dart';
import 'colors.dart';

// Build and sign:
// https://flutter.dev/docs/deployment/android
// TODO: Admob
//  - Need to setup firebase project
// https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter/#3
// TODO: Deploy:
// https://developer.android.com/studio/publish/app-signing#app-signing-google-play


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FoodState>(create: (_) => FoodState()),
      ],
      child: App(),
    )
    // ChangeNotifierProvider(
    //   create: (context) => FoodState(),
    //   child: App(),
    // )
  );
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}
class _AppState extends State<App> {
  BannerAd _bannerAd;

  Future<void> _initAdMob() {
    /// Initialize AdMob SDK
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  @override
  void initState() {
    _initAdMob();

    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

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
