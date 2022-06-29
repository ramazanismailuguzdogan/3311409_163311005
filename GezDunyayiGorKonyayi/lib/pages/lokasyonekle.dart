import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gezdunyayigorkonyayi/db/lokasyonDb.dart';
import 'package:gezdunyayigorkonyayi/model/lokasyon.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyoneklemebasarili.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasyonEkle extends StatelessWidget {
  LatLng? konumData;
  final textBaslikController = TextEditingController();
  final textAciklamaController = TextEditingController();
  final textaniController = TextEditingController();
  double lokasyonRating = 0.0;

  LokasyonEkle({required LatLng konum, Key? key}) : super(key: key) {
    this.konumData = konum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasyon Ekle"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 4),
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Lütfen Aşağıdaki Kısma Eklemek İstediğiniz Lokasyon Bilgilerini Giriniz.",
                  style:
                      TextStyle(fontFamily: "Roboto-LightItalic", fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: textBaslikController,
                        decoration: InputDecoration(
                          hintText: 'Lokayon Başlığı',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy-Medium",
                          ),
                          prefixIcon: Icon(
                            Icons.subject,
                            size: 20,
                            color: Colors.indigo,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: textAciklamaController,
                        maxLines: 8, //or null
                        decoration: InputDecoration.collapsed(
                          hintText: 'Lokasyon açıklamasını bu alana yazınız...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy-Medium",
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: textaniController,
                        maxLines: 8, //or null
                        decoration: InputDecoration.collapsed(
                          hintText: 'Lokasyondaki anınızı bu alana yazınız...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy-Medium",
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text("Bu Lokasyona Verdiğiniz Puan"),
                    SizedBox(
                      height: 12,
                    ),
                    RatingBar.builder(
                      initialRating: lokasyonRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 10,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        lokasyonRating = rating;
                      },
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 220,
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 0,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Color(0xff2972ff),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  addLokasyon().then((lokasyonAddSonuc) {
                                    return Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LokasyonEklemeBasarili()));
                                  });
                                },
                                borderRadius: BorderRadius.circular(10.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_location_alt,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Lokasyon Ekle",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto-Medium",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addLokasyon() async {
    final lokasyon = Lokasyon(
        baslik: textBaslikController.text,
        aciklama: textAciklamaController.text,
        ani: textaniController.text,
        puan: lokasyonRating.toString(),
        dataLat: konumData!.latitude.toString(),
        dataLon: konumData!.longitude.toString(),
        tarih: DateTime.now());
    await LokasyonDatabase.instance.create(lokasyon);
  }
}
