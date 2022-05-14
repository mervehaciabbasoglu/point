import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

class Database {
  final cloud_firestore.FirebaseFirestore _firestore = cloud_firestore.FirebaseFirestore.instance;

  Future<void> createCategoryData(
      String name, String gender, int score, String uid) async {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('categories');
    return await categoryList
        .doc(uid)
        .set({'name': name, 'gender': gender, 'score': score});
  }

  Future updateCategoryList(String name, String gender, int score, String uid) async {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('categories');
    return await categoryList.doc(uid).update({
      'name': name, 'gender': gender, 'score': score
    });
  }

  Future fetchCategories() async {
    cloud_firestore.CollectionReference categoryList  = _firestore.collection('categories');

    List itemsList = [];

    try {
      await categoryList.get().then((querySnapshot) {
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
