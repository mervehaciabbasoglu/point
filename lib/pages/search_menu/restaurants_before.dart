import 'package:flutter/material.dart';


class RestaurantsBefore extends StatefulWidget {
  const RestaurantsBefore({Key? key}) : super(key: key);

  @override
  State<RestaurantsBefore> createState() => _RestaurantsBeforeState();
}

class _RestaurantsBeforeState extends State<RestaurantsBefore> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Önceden Gittiğim Restoranlar'),
      centerTitle: true,
      backgroundColor: Colors.purpleAccent,
    ),
  );
}
