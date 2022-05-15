import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point/widgets/category_card.dart';
import 'package:point/widgets/search_bar.dart';
import 'package:point/services/database_service.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  List categoryList = [];


  @override
  void initState() { // ilk yapılması gereken şeyler buraya yazılır.
    super.initState();
    fetchCategories(); // burada kategorileri çektik. init state'e yazdık çünkü kullanıcı açar açmaz bunları görecek.
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    List<Widget> listCards = [];
    categoryList.forEach((data){
      var category = data();
      listCards.add(CategoryCard(
        title: category['name'],
        imgSrc: category["image"],
        press: () {
        },
      ));
    });


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
                      child: Image.asset("assets/icons/menu.png"),
                    ),
                  ),
                  Text(
                    "RESTORANLAR",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SearchBar(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget> [...listCards],
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

















