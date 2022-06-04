import 'package:flutter/material.dart';



class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Yardım'),
      centerTitle: true,
      backgroundColor: Colors.purpleAccent,
    ),
  );
}
