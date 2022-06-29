import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gezdunyayigorkonyayi/db/lokasyonDb.dart';
import 'package:gezdunyayigorkonyayi/model/lokasyon.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonduzenlemebasarili.dart';

class LokasyonDuzenle extends StatefulWidget {
  Lokasyon? lokasyonData;

  LokasyonDuzenle({required Lokasyon lokasyon, Key? key}) : super(key: key) {
    this.lokasyonData = lokasyon;
  }

  @override
  State<LokasyonDuzenle> createState() => _LokasyonDuzenleState();
}

class _LokasyonDuzenleState extends State<LokasyonDuzenle> {
  final textBaslikController = TextEditingController();

  final textAciklamaController = TextEditingController();

  final textaniController = TextEditingController();

  double lokasyonRating = 0.0;

  @override
  initState() {
    super.initState();

    textBaslikController.text = widget.lokasyonData!.baslik;
    textAciklamaController.text = widget.lokasyonData!.aciklama;
    textaniController.text = widget.lokasyonData!.ani;
    lokasyonRating = double.parse(widget.lokasyonData!.puan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasyon Listesi"),
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
                                  LokasyonDatabase.instance
                                      .update(Lokasyon(
                                    id: widget.lokasyonData!.id,
                                          baslik: textBaslikController.text,
                                          aciklama: textAciklamaController.text,
                                          ani: textaniController.text,
                                          puan: lokasyonRating.toString(),
                                          dataLat: widget.lokasyonData!.dataLat,
                                          dataLon: widget.lokasyonData!.dataLon,
                                          tarih: widget.lokasyonData!.tarih))
                                      .then((value) {
                                    return Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LokasyonDuzenlemeBasarili()));
                                  });
                                },
                                borderRadius: BorderRadius.circular(10.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit_location_sharp,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Lokasyonu Düzenle",
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
}
