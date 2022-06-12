import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();

}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  get EmailValidator => [];

  get Utils => [];
  //TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  Widget build(BuildContext) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: const Text('Şifreyi Yenile'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Şifrenizi sıfırlamak için bir e-posta alın',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ben Yokum!';
                } else if (value.length < 2) {
                  return 'Ben Varım ama az varım';
                }
              }
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.email_outlined),
              label: const Text(
                'Şifreyi yenile',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: (){} ,
            ),
          ],
        ),
      ),
    ),
  );

  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Şifreyi sıfırlamak için link E-postaya gönderildi');
      Navigator.of(context).popUntil((route) => route.isFirst);

    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}




 /*Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
            "Şifreyi Yenile",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: linearGradient(colors: [
            hexStringToColor("CB2093"),
            hexStringToColor("9546C4"),
            hexStringToColor("9546C4"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Eposta adresini giriniz", Icons.person_outline,false,
                    _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  firbaseButton(context, "Şifreyi Yenile", () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailTextController.text)
                        .then((value) => Navigator.of(context).pop());
                  })
                ],
              ),
            ),
          )
        ),
      ),
    );*/

