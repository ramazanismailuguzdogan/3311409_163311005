import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/pages/home.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonlistesi.dart';

class LokasyonDuzenlemeBasarili extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasyon Düzenleme Başarılı"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.sms_failed_rounded,
            size: 50,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Seçilen lokasyon başarılı\nbir şekilde düzenlendi",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => HomePage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(4)),
              width: 134,
              child: Row(
                children: [
                  Icon(Icons.home, color: Colors.white),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Anasayfaya dön",
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