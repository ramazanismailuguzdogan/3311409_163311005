import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/lokasyonDb.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonduzenlemebasarili.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonsilmebasarili.dart';

class LokasyonSilmeOnayi extends StatelessWidget {
  int? lokasyonId;
  LokasyonSilmeOnayi({required int id, Key? key}) : super(key: key) {
    this.lokasyonId = id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasyon Silme Onayı"),
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
                "Seçilen lokasyonu silmek istediğinize\nemin misiniz?",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  LokasyonDatabase.instance.delete(lokasyonId!).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LokasyonSilmeBasarili()));
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(4)),
                  width: 110,
                  child: Row(
                    children: [
                      Icon(Icons.wrong_location_sharp, color: Colors.white),
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
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(4)),
                  width: 90,
                  child: Row(
                    children: [
                      Icon(Icons.not_listed_location_sharp,
                          color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Vazgeç",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
