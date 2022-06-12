import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final cloud_firestore.FirebaseFirestore _firestore = cloud_firestore.FirebaseFirestore.instance;

  //future: aync çalıştırmak için kullanılır. //dataları oluşturdupğumuz yer ama tek tek
  Future createCategoryData(String name, String plural, String image, String uid) async
  {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('categories');
    return await categoryList
        .doc(uid)
        .set({'name': name, 'plural': plural, 'image': image});
  }


  //future: aync çalıştırmak için kullanılır. //dataları oluşturdupğumuz yer ama tek tek
  Future createAddressData(String town, String name, String address, String uid) async
  {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('addresses');
    return await categoryList
        .doc(uid)
        .set({'town': town, 'name': name, 'address': address});
  }
  // methodun içinde return varsa method dönüyor demektir. methodun döndüğü değerin tipi methodun tipidir.method tipi(int string) eğer return yoksa method bir şey dönmüyor demektir
  // bu yüzden başına void yazılır.

  Future updateCategoryList(String name, String gender, int score, String uid) async {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('categories');
    return await categoryList.doc(uid).update({
      'name': name, 'gender': gender, 'score': score
    });
  }


  Future fetchRestaurants({String? category, String? restaurant}) async {

    Future<Object> searchByRestaurantName(String? searchField) async {
      searchField = searchField.toString().toLowerCase();
      List itemsList = [];
      try {
        await _firestore.collection('restaurants')
            .where('name', isGreaterThanOrEqualTo: searchField, isLessThan: searchField.toString().substring(0, searchField.length-1) + String.fromCharCode(searchField.codeUnitAt(searchField.length - 1) + 1))
            .get().then((querySnapshot) {

          print(querySnapshot.docs.length);
          print("querySnapshot");
          for (var element in querySnapshot.docs) {
            itemsList.add(element.data());
          }
        });
        return itemsList;
      } catch (e) {
        print(e.toString());
        return [];
      }
    }
    Future<Object> searchByCategoryReference(String searchField) async {
      List itemsList = [];
      try {
        await _firestore.collection('restaurants').where("category", isEqualTo: searchField)
            .get().then((querySnapshot) {
          print(querySnapshot.docs.length);
          for (var element in querySnapshot.docs) {
            itemsList.add(element.data());
          }
        });
        return itemsList;
      } catch (e) {
        print(e.toString());
        return [];
      }
    }

    if(category != null){
      return await searchByCategoryReference(category);
    }
    return await searchByRestaurantName(restaurant);

  }

  Future fetchCategories() async {
    cloud_firestore.CollectionReference dataList  = _firestore.collection("categories");

    List itemsList = [];

    try {
      await dataList.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add({"data":element.data(),"id":element.reference.id});
        }
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future fetchAddresses() async {
    cloud_firestore.CollectionReference dataList  = _firestore.collection("addresses");

    List itemsList = [];
    try {
      await dataList.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add({"data":element.data(),"id":element.reference.id});
        }
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
