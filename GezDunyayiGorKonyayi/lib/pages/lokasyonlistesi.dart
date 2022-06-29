import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/lokasyonDb.dart';
import 'package:gezdunyayigorkonyayi/model/lokasyon.dart';
import 'package:gezdunyayigorkonyayi/pages/haritadagor.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonduzenle.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonsilmeonayi.dart';

class LokasyonListesi extends StatefulWidget {

  @override
  State<LokasyonListesi> createState() => _LokasyonListesiState();
}

class _LokasyonListesiState extends State<LokasyonListesi> {

  List<Lokasyon> lokasyonListesi = [];

  @override
  initState(){
    super.initState();
    lokasyonListesiCek();
  }

  void lokasyonListesiCek() {
    LokasyonDatabase.instance.readAllLokasyonlar().then((value) {
      setState((){
        lokasyonListesi = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasyon Listesi"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              minLeadingWidth: 0,
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 26,
                    color: Colors.redAccent,
                  ),
                ],
              ),
              title: Text(
                lokasyonListesi[index] == null?"":lokasyonListesi[index].baslik,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lokasyonListesi[index] == null?"":lokasyonListesi[index].aciklama),
                  Text(
                    lokasyonListesi[index] == null?"":lokasyonListesi[index].ani,
                    style: TextStyle(fontSize: 12, color: Colors.indigoAccent),
                  )
                ],
              ),
              trailing: SizedBox(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HaritadaGor(
                                    lokasyon: lokasyonListesi[index])));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4)),
                        width: 40,
                        child: Icon(Icons.directions, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LokasyonDuzenle(
                                    lokasyon: lokasyonListesi[index])));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(4)),
                        width: 40,
                        child: Icon(Icons.edit_location_sharp,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LokasyonSilmeOnayi(
                                      id: lokasyonListesi[index].id!,
                                    )));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)),
                        width: 40,
                        child: Icon(Icons.delete_forever, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                width: 140,
              ),
            );
          },
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 4),
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: lokasyonListesi.length),
    );
  }
}
