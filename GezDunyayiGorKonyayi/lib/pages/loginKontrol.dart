import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/kullaniciDb.dart';
import 'package:gezdunyayigorkonyayi/model/kullanici.dart';
import 'package:gezdunyayigorkonyayi/pages/login.dart';
import 'package:gezdunyayigorkonyayi/pages/autologinloading.dart';

class LoginKontrol extends StatefulWidget {
  @override
  State<LoginKontrol> createState() => _LoginKontrolState();
}

class _LoginKontrolState extends State<LoginKontrol> {
  Timer? timer;
  double turns = 0.0;
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        turns += 1.0 / 8.0;
      });
    });
    Timer(Duration(seconds: 4), () {
      userKontrol().then((user) {
        if (user != null) {
        Navigator.push(
              context, MaterialPageRoute(builder: (context) => AutoLoginLoading(email: user.email,password: user.password,)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage()));
        }
      });
    });
  }

  Future<User?> userKontrol() async {
    var users = await KullaniciDatabase.instance.readAllUsers();
    return users.length == 0 ? null : users.first;
  }
  @override
  dispose() {
    super.dispose();
    timer = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              child: AnimatedRotation(
                turns: turns,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/images/logo.png",height: 150,width: 150,),
              ),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Align(
                child: Text("Gez Dünya'yı Gör Konya'yı\nUygulamasına Hoşgeldiniz",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
