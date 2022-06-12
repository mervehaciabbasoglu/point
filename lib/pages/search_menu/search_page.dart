import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point/pages/login_page.dart';
import 'package:point/pages/search_menu/drawer.dart';
import 'package:point/widgets/category_card.dart';
import 'package:point/services/database_service.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Widget> restaurantCards = [];
  List<Widget> categoryCards = [];
  TextEditingController searchController = TextEditingController();
  int axisCount = 2;
  String filterTown = "Kadıköy";



  @override
  void initState() { // ilk yapılması gereken şeyler buraya yazılır.
    super.initState();
    fetchCategories(); // burada kategorileri çektik. init state'e yazdık çünkü kullanıcı açar açmaz bunları görecek.
    fetchRestaurants();
  }

  fetchCategories() async {

    dynamic categoryList = await Database().fetchCategories(); //dynamic: datalar sürekli değişiyorsa dynamic gerekli

    if (categoryList == null) {
      print('Unable to retrieve');
    } else {
      setState(() {

        categoryList.forEach((category){
          categoryCards.add(CategoryCard(
            title: category['data']['name'],
            imgSrc: category['data']['image'],
            press: () {
              fetchRestaurants(category:category['id'].toString());
            },
          ));
        });
      });
    }
  }

  fetchRestaurants({String? category, String? restaurant}) async {
    dynamic restaurantList = await Database().fetchRestaurants(category:category, restaurant:restaurant); //dynamic: datalar sürekli değişiyorsa dynamic gerekli
    restaurantCards = [];
    if (restaurantList == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        restaurantList.forEach((data){
          restaurantCards.add(CategoryCard(
            title: data['name'] + " (" + data['county'] + ")",
            imgSrc: data["logo"],
            press: () {
            },
          ));
        });
        axisCount = 1;
      });
    }
  }

  logout() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginPage()));
  }


  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }


  void submit() async{
    Navigator.of(context).pop();
  }

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Filtreler'),
      content: DropdownButton<String>(
        isExpanded: true,
        value: filterTown,
        hint: const Text("Select Town"),
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isDense: true,
        onChanged: (String? newValue) {
          setState(() {
            filterTown = newValue!;
          });
        },
        items: <String>['Kadıköy', 'Üsküdar', 'Beşiktaş', 'Beykoz']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          child: const Text('Uygula'),
          onPressed: submit,
        )
      ], // TextButton
    ),
  );


  @override
  Widget build(BuildContext context) {
    final _name = Scaffold();
    var size = MediaQuery.of(context).size; //this gonna give us total height and with of our device

    Future _changedSearch(String value) async{
      if(value.isNotEmpty){
        restaurantCards = [];
        axisCount = 1;
        await fetchRestaurants(restaurant: value);
        return;
      }
      axisCount = 2;
      categoryCards = [];
      await fetchCategories();
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavBar(),
      body: Stack(
        children: <Widget>[

          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .30,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 77,
                          width: 45,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2BEA1),
                            shape: BoxShape.circle,
                          ),

                          child: TextButton(
                              onPressed: (){
                                toggleDrawer();
                              },
                              child: Image.network("https://img.icons8.com/material-outlined/24/000000/menu--v4.png")

                          ),
                        ),
                      ),

                      Text(
                        "ev"
                        ,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.w900,
                            color: Colors.black54,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 77,
                          width: 45,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2BEA1),
                            shape: BoxShape.circle,
                          ),
                          child: TextButton(
                              onPressed: (){
                                logout();
                              },
                              child: Image.network("https://cdn.icon-icons.com/icons2/2943/PNG/512/logout_icon_184025.png")

                          ),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    (axisCount == 2) ? "KATEGORİLER" : "RESTORANLAR",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Expanded(
                          child:TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: "Search",
                            icon: Icon(
                              FontAwesomeIcons.search,
                              color: Colors.black,
                              size: 25.0,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (String value) async {
                            print(value);
                            _changedSearch(value);
                          },
                        )),
                        ElevatedButton(
                            onPressed: () {
                              openDialog();
                            },
                            child: const Text(
                              "Filtrele",
                            ))
                      ],
                    ),
                  ), Expanded(child:

                  axisCount == 2 && categoryCards.isNotEmpty ?

                  GridView.count(
                    crossAxisCount: axisCount,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children:  <Widget> [...categoryCards],
                  )

                    : axisCount == 1 && restaurantCards.isNotEmpty ?

                  GridView.count(
                    crossAxisCount: axisCount,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children:   <Widget> [...restaurantCards],
                  ) :
                  const Text("Not Found"),
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














