import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search",
          icon: Icon(
            FontAwesomeIcons.search,
            color: Colors.black,
            size: 22.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}