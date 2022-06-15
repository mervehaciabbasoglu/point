import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:point/pages/search_menu/search_page.dart';
import '../../services/database_service.dart';

class RestaurantMenuPage extends StatefulWidget {
  final String restaurantKey;
  final String restaurantName;
  const RestaurantMenuPage(
      {Key? key, required this.restaurantKey, required this.restaurantName})
      : super(key: key);

  @override
  State<RestaurantMenuPage> createState() =>
      _RestaurantMenuPageState(restaurantKey, restaurantName);
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  List menuList = [];
  String restaurantKey;
  String restaurantName;
  _RestaurantMenuPageState(this.restaurantKey, this.restaurantName);

  fetchMenus() async {
    dynamic data = await Database().fetchMenus(
        restaurant: this
            .restaurantKey); //dynamic: datalar sürekli değişiyorsa dynamic gerekli

    if (data == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        // setState: gelen dataları widgetların kullanımına sunar
        menuList = data;
      });
    }
  }

  @override
  void initState() {
    // ilk yapılması gereken şeyler buraya yazılır.
    super.initState();
    fetchMenus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Navigator.pop(context),
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => SearchPage()))
            },
          ),
          title: Text(this.restaurantName.toString().toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Expanded(
              child: menuList.length > 0
                  ? ListView.builder(
                      itemCount: menuList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            elevation: 2.0,
                            color: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(menuList[index]['name']
                                        .toString()
                                        .toUpperCase()),
                                    Text(
                                        menuList[index]['currency'].toString() +
                                            menuList[index]['price'].toString())
                                  ],
                                )));
                      },
                    )
                  : const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text("Menu Not Found")),
            )
          ],
        ),
      );
}

Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('addresses')
                    .snapshots(),
                builder: (context, snapshot) {
                  final addresses = snapshot.data?.docs;
                  if (addresses == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (addresses.isEmpty) {
                    return const Center(
                      child: Text('henüz adres eklenmedi'),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final adres1 = addresses[index];
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  adres1['adres1'],
                                  style: TextStyle(),
                                ),
                              ],
                            )),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
