import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text('PROFİLİM'),
              accountEmail: const Text('example@gmailcom'),
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
              color: Colors.blue,
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
            title: Text('Favori mekanlarım'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: const Text('Gitmek İstediğim Mekanlar'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Önceden Gittiklerim'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.navigation),
            title: Text('kayıtlı Konumlarım'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Yardım'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
