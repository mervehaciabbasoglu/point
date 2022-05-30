import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
                  'https://www.istockphoto.com/tr/vekt%C3%B6r/woman-front-face-cartoon-avatar-icon-gm613880840-106063081',
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
            leading: const Icon(Icons.favorite),
            title: const Text('Favori mekanlarım'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Gitmek İstediğim Mekanlar'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Önceden Gittiklerim'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.navigation),
            title: const Text('Adreslerim'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Yardım'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Çıkış'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}


