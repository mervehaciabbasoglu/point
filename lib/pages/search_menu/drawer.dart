import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:point/pages/search_menu/address_form.dart';
import 'package:point/pages/search_menu/favorite_restaurants.dart';
import 'package:point/pages/search_menu/restaurants_before.dart';

import 'help_page.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;
  late String? email = _auth.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('PROFİLİM'),
            accountEmail: Text(email.toString()),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://img.icons8.com/office/344/user-female-skin-type-5.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.purpleAccent,
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.pexels.com/tr-tr/fotograf/gradyan-cok-renkli-gradyan-arka-plani-renk-gecisi-7130555/'
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Adreslerim'),
            onTap: () => {
               Navigator.pop(context),
               Navigator.push(context, MaterialPageRoute(builder: (c)=> const AddressForm())),
              },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: const Text('Favori Restoranlar'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const FavoriteRestaurants())),
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Önceden Gittiklerim'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const RestaurantsBefore())),
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Yardım'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HelpPage())),
            },
          ),
        ],
      ),
    );
  }
}
