import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/kullaniciDb.dart';
import 'package:gezdunyayigorkonyayi/model/kullanici.dart';
import 'package:gezdunyayigorkonyayi/pages/home.dart';
import 'package:gezdunyayigorkonyayi/pages/login.dart';
import 'package:gezdunyayigorkonyayi/service/auth_service.dart';

class LoginLoading extends StatefulWidget {
  String? emailData;
  String? passwordData;

  LoginLoading({required String email, required String password, Key? key})
      : super(key: key) {
    this.emailData = email;
    this.passwordData = password;
  }

  @override
  State<LoginLoading> createState() => _LoginLoadingState();
}

class _LoginLoadingState extends State<LoginLoading> {
  double turns = 0.0;
  Timer? timer;
  AuthService _authService = AuthService();

  @override
  initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        turns += 1.0 / 8.0;
      });
    });

    Timer(Duration(seconds: 2), () {
      _authService
          .signIn(widget.emailData!, widget.passwordData!)
          .then((authSonuc) {
        addUsers(widget.emailData!, widget.passwordData!).then((userAddSonuc) {
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      }).onError((error, stackTrace) {
        KullaniciDatabase.instance.deleteAll();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    });
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
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                  width: 150,
                ),
              ),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Align(
                child: Text(
                  "Hesabınıza giriş yapılıyor lütfen bekleyiniz...",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future addUsers(String email, String password) async {
    final user = User(
      email: email,
      password: password,
    );
    await KullaniciDatabase.instance.create(user);
  }
}
