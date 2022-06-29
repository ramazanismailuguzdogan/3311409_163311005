import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/kullaniciDb.dart';
import 'package:gezdunyayigorkonyayi/model/kullanici.dart';
import 'package:gezdunyayigorkonyayi/pages/login.dart';
import 'package:gezdunyayigorkonyayi/pages/register.dart';
import 'package:gezdunyayigorkonyayi/service/auth_service.dart';

class RegisterLoading extends StatefulWidget {
  String? userNameData;
  String? emailData;
  String? passwordData;
  String? profileImageSourceData;

  RegisterLoading(
      {required String userName,
      required String email,
      required String password,
      required String profileImageSource,
      Key? key})
      : super(key: key) {
    this.userNameData = userName;
    this.emailData = email;
    this.passwordData = password;
    this.profileImageSourceData = profileImageSource;
  }

  @override
  State<RegisterLoading> createState() => _RegisterLoadingState();
}

class _RegisterLoadingState extends State<RegisterLoading> {
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
          .createPerson(
              widget.userNameData!,
              widget.emailData!,
              widget.passwordData!,
              widget.profileImageSourceData!,
              DateTime.now().toString())
          .then((value) {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }).onError((error, stackTrace) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
                  "Hesabınız oluşturuluyor lütfen bekleyiniz...",
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
