 import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/model/haber.dart';
import 'package:gezdunyayigorkonyayi/pages/habericerik.dart';
import 'package:gezdunyayigorkonyayi/service/apiServis.dart';

class ViewHaberler extends StatefulWidget {
  @override
  State<ViewHaberler> createState() => _ViewHaberlerState();
}

class _ViewHaberlerState extends State<ViewHaberler> {
  List<HaberModel> haberListesi = [];

  @override
  initState() {
    super.initState();
    haberleriGetir();
  }

  bool yuklenmeDurumu = true;

  void haberleriGetir() {
    ApiServis.haberleriGetir().then((sonuc) {
      if (sonuc.statusCode == 200) {
        Iterable list = json.decode(sonuc.body);
        setState(() {
          yuklenmeDurumu = false;
          haberListesi =
              list.map((haberler) => HaberModel.fromJson(haberler)).toList();
        });
      } else {
        throw ('Error occured while Communication with Server. StatusCode: ${sonuc.statusCode}');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Haberler")),
      body: yuklenmeDurumu == true
          ? Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 30,
                ),
                Text("Haberler Yükleniyor...")
              ],
            ))
          : (haberListesi.isEmpty == true
              ? Container()
              : ListView.separated(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 4),
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: haberListesi.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                haberListesi[index].icerikCover!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(haberListesi[index].icerikTitle!),
                      ),
                      subtitle: Text(
                          haberListesi[index].icerikContent!.length > 100
                              ? haberListesi[index]
                                      .icerikContent!
                                      .substring(0, 96)
                                      .replaceAll("\n", "") +
                                  "..."
                              : haberListesi[index].icerikContent!),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HaberIcerik(haberListesi[index])));
                      },
                      minVerticalPadding: 20,
                    );
                  },
                )),
    );
  }
}
