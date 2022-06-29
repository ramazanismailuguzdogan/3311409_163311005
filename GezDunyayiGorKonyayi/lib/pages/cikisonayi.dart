import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/kullaniciDb.dart';
import 'package:gezdunyayigorkonyayi/pages/login.dart';
import 'package:gezdunyayigorkonyayi/service/auth_service.dart';
class CikisOnayi extends StatelessWidget{
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Çıkış Onayı"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_alert,
            size: 50,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Hesabınızdan çıkış yapmak istediğinize\nemin misiniz?",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _authService.signOut();
              KullaniciDatabase.instance.deleteAll();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4)),
              width: 114,
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, color: Colors.white,size: 22,),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Evet Eminim",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}