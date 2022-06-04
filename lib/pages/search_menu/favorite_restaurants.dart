import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FavoriteRestaurants extends StatefulWidget {
  const FavoriteRestaurants({Key? key}) : super(key: key);

  @override
  State<FavoriteRestaurants> createState() => _FavoriteRestaurantsState();
}

class _FavoriteRestaurantsState extends State<FavoriteRestaurants> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Favori Restoranlarım'),
      centerTitle: true,
      backgroundColor: Colors.purpleAccent,
    ),
    );
  }


