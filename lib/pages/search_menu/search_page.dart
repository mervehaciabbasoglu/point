import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point/pages/login_page.dart';
import 'package:point/widgets/category_card.dart';
import 'package:point/services/database_service.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  List categoryList = [];
  List restaurantList = [];

  List<Widget> restaurantCards = [];
  List<Widget> categoryCards = [];
  TextEditingController searchController = TextEditingController();
  int axisCount = 2;


  @override
  void initState() { // ilk yapılması gereken şeyler buraya yazılır.
    super.initState();
    fetchCategories(); // burada kategorileri çektik. init state'e yazdık çünkü kullanıcı açar açmaz bunları görecek.
    fetchRestaurants();
  }

  fetchCategories() async {

    dynamic data = await Database().fetchCategories(); //dynamic: datalar sürekli değişiyorsa dynamic gerekli

    if (data == null) {
      print('Unable to retrieve');
    } else {
      setState(() { // setState: gelen dataları widgetların kullanımına sunar
        categoryList = data;
      });
    }
  }

  fetchRestaurants({String? category}) async {
    dynamic data = await Database().fetchRestaurants(category:category); //dynamic: datalar sürekli değişiyorsa dynamic gerekli

    if (data == null) {
      print('Unable to retrieve');
    } else {
      setState(() { // setState: gelen dataları widgetların kullanımına sunar
        restaurantList = data;
      });
    }
  }

  logout() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    categoryList.forEach((category){
      categoryCards.add(CategoryCard(
        title: category['data']['name'],
        imgSrc: category['data']['image'],
        press: () {
          fetchRestaurants(category:category['id']);
          searchController.text = category['data']['name'];
          searchController.value = category['data']['name'];
          axisCount = 1;
        },
      ));
    });

    _changedSearch(String value){
      print(value);
      categoryCards = [];
      restaurantCards = [];
      if(value.isNotEmpty){
        axisCount = 1;
        fetchRestaurants();
        restaurantList.forEach((data){
          var category = data();
          restaurantCards.add(CategoryCard(
            title: category['name'],
            imgSrc: category["logo"],
            press: () {
            },
          ));
        });
      }else{
        axisCount = 2;
        fetchCategories();
        categoryList.forEach((category){
          categoryCards.add(CategoryCard(
            title: category['data']['name'],
            imgSrc: category['data']['image'],
            press: () {
              axisCount = 1;
              fetchRestaurants(category:category['id']);
              searchController.text = category['data']['name'];
              searchController.value = category['data']['name'];
            },
          ));
        });
      }
      print(axisCount);
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/img/background.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: TextButton(
                        onPressed: () { logout(); },
                        child: Image.asset("assets/icons/menu.png"),

                      ),
                    ),

                  ),
                  Text(
                    (axisCount == 2) ? "KATEGORİLER" : "RESTORANLAR"
                    ,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: Colors.black,
                          size: 22.0,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (String value) async {
                        _changedSearch(value);
                      },
                    ),
                  ), Expanded(child: GridView.count(
                      crossAxisCount: axisCount,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children:  (axisCount == 2) ? <Widget> [...categoryCards] : <Widget> [...restaurantCards],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}














