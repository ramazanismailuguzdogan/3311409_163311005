import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/model/haber.dart';
import 'package:share_plus/share_plus.dart';

class HaberIcerik extends StatelessWidget {
  HaberModel? haberData;
  HaberIcerik(HaberModel haber, {Key? key}) : super(key: key) {
    this.haberData = haber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        //backgroundColor: HexColor("#f8f9fa"),
        backgroundColor: Colors.white,
        titleSpacing: -4.0,
        title: Text(
          "Haber Detayı",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          iconSize: 36.0,
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 36.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () {
                Share.share(
                    (haberData!.icerikTitle! +
                        "\n\n" +
                        haberData!.icerikContent! +
                        "\n\n" +
                        haberData!.icerikUrl!),
                    subject: 'Bu Haber Gez Dünyayı Gör Konya\'yı Tarafından Paylaşıldı');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 200, maxHeight: 600),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(haberData!.icerikCover!)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    haberData!.icerikTitle!,
                    style: TextStyle(
                        fontFamily: "Roboto-Black",
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Icon(Icons.person),
                          ),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "TRT Haber",
                          style: TextStyle(
                              fontFamily: "Roboto-Medium",
                              fontSize: 13),
                        ),
                      ),
                      Text(
                        haberData!.icerikDate!,
                        style: TextStyle(
                            fontFamily: "Roboto-Light", fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            haberData!.icerikContent!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: "Roboto-LightItalic",
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
