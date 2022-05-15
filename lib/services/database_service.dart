import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

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
  // methodun içinde return varsa method dönüyor demektir. methodun döndüğü değerin tipi methodun tipidir.method tipi(int string) eğer return yoksa method bir şey dönmüyor demektir
  // bu yüzden başına void yazılır.

  Future updateCategoryList(String name, String gender, int score, String uid) async {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('categories');
    return await categoryList.doc(uid).update({
      'name': name, 'gender': gender, 'score': score
    });
  }


  Future fetchData(String collectionName) async {
    cloud_firestore.CollectionReference dataList  = _firestore.collection(collectionName);

    List itemsList = [];

    try {
      await dataList.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.data);
        }
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
