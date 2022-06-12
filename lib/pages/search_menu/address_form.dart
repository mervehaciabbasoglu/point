import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/database_service.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  List addressList = [];
  List<Widget> addressCards = [];
  late TextEditingController new_address_controller;
  String address = "";
  String town = "Kadıköy";

  fetchAddresses() async {
    dynamic data = await Database()
        .fetchAddresses(); //dynamic: datalar sürekli değişiyorsa dynamic gerekli

    if (data == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        // setState: gelen dataları widgetların kullanımına sunar
        addressList = data;
      });
    }
  }

  @override
  void initState() {
    // ilk yapılması gereken şeyler buraya yazılır.
    super.initState();
    new_address_controller=TextEditingController();
    fetchAddresses();
  }

  @override
  void dispose(){
    new_address_controller.dispose();
    super.dispose();
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
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                          addressList[index]['data']['name'].toString() +
                              " " +
                              addressList[index]['data']['adres1'].toString()),
                    ),
                    color: Colors.white70,
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final address = await openDialog();
                  if(address == null || address.isEmpty) return;

                  setState(()=>{
                    this.address = address
                  });

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent,
                ),
                child: const Text(
                  "Yeni Adres Ekle",
                ))
          ],
        ),
      );

  void submit(){
    Navigator.of(context).pop(new_address_controller.text);
    new_address_controller.clear();
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Yeni Adres'),
          content: Column(
            children: [
              DropdownButton<String>(
                isExpanded: true,
                value: town,
                hint: const Text("Select Town"),
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    town = newValue!;
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
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: "Adresi Giriniz"),
                controller: new_address_controller,
                onSubmitted: (_) => submit(),
              )
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Ekle'),
              onPressed: submit,
            )
          ], // TextButton
        ),
      );

}

final TextEditingController _controller = TextEditingController();

Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('addresses')
                    .snapshots(),
                builder: (context, snapshot) {
                  final addresses = snapshot.data?.docs;
                  if (addresses == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (addresses.isEmpty) {
                    return const Center(
                      child: Text('henüz adres eklenmedi'),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final adres1 = addresses[index];
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  adres1['adres1'],
                                  style: TextStyle(),
                                ),
                              ],
                            )),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
