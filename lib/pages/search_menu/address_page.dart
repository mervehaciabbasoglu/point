import 'package:flutter/material.dart';
import '../../services/database_service.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List addressList = [];
  List<Widget> addressCards = [];

  fetchAddresses() async {

    dynamic data = await Database().fetchAddresses(); //dynamic: datalar sürekli değişiyorsa dynamic gerekli

    if (data == null) {
      print('Unable to retrieve');
    } else {
      setState(() { // setState: gelen dataları widgetların kullanımına sunar
        addressList = data;
      });
    }
  }

  @override
  void initState() { // ilk yapılması gereken şeyler buraya yazılır.
    super.initState();
    fetchAddresses();

  }


            @override
            Widget build(BuildContext context) => Scaffold(
            appBar: AppBar(
            title: Text('Adres Bilgilerim'),
            centerTitle: true,
            backgroundColor: Colors.purpleAccent,
            ),
            body: Column(
            children: [
            Expanded(
            child: ListView.builder(
            itemCount: addressList.length,
            itemBuilder: (BuildContext context, int index)
            {
            return Card(
            elevation: 5.0,
            child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(addressList[index]['data']['name'].toString() + " " +
                      addressList[index]['data']['adres1'].toString()),
                  ),
                  color: Colors.white70,
                );
              },
          ),
        ),
      ],
    ),
  );
}





// birlşetirme(kelime1, kelime2, no){
//
//   return kelime1+kelime2+no.toString()
// }
//
// birlestirme("merve", "arif", 6)


// toString() camelCase
// to_string() snake_case
// to-string() kebab-case

// ToString() PascalCase
// To String() Title Case

// arifMerveyiSeviyor




//  type key/keyword = value
// final int tc_kimlik_no = 9854376984576
// string name = "isim"
// String  surname = "hacıabbasoğlu"
// int age = 21
// Boolean sen_kadınmısın = True
// Function say(){
//    return 1+2+3*
// }
// Object mervenin_bilgileri {
//     String name = "isim"
//     String  surname = "hacıabbasoğlu"
//
//     Object mervenin_is_deneyimleri {
//         String name "son işim"
//         int kacyıl calışsuım 2
//     }
// }
// array/list mervenin_kitapleri = ["küçük prens", "çalıkuşu", 22, True, Function, Object, Array, Widget]
//
// mervenin_kitapleri.add("peyami safa")
//
//     Array addresses [
// {
// address1 = "sdfg"
// address="dfgdfg",
// name="merve"
// },
// {
// address1 = "sdfg"
// address="dfgdfg",
// name="merve"
// }
// {
// address1 = "sdfg"
// address="dfgdfg",
// name="merve"
// },
// {
// address1 = "sdfg"
// address="dfgdfg",
// name="merve"
// }
// ]
//
// addresses.forEach((mahmut)=>{
//    print(mahmut.name)
// })
//
// array _items = [1, 2, 3, 4,11, 22, 33, 44,10, 20, 30, 40];
//
// _items.forEach((item)=>{
//
// })