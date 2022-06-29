import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/kullaniciDb.dart';
import 'package:gezdunyayigorkonyayi/db/lokasyonDb.dart';
import 'package:gezdunyayigorkonyayi/pages/cikisonayi.dart';
import 'package:gezdunyayigorkonyayi/pages/login.dart';
import 'package:gezdunyayigorkonyayi/pages/profilDuzenle.dart';
import 'package:gezdunyayigorkonyayi/service/auth_service.dart';
import 'package:graphic/graphic.dart';

class ViewProfil extends StatefulWidget {
  const ViewProfil({Key? key}) : super(key: key);

  @override
  State<ViewProfil> createState() => _ViewProfilState();
}

class _ViewProfilState extends State<ViewProfil> {
  AuthService _authService = AuthService();

  String kullaniciAdi = "";

  @override
  void initState() {
    super.initState();
    kullaniciVeriCek();
    lokasyonListesiCek();
  }

  String? profileImageData = "null";
  DocumentSnapshot? snapshot;
  void kullaniciVeriCek() {
    _authService.getPerson().then((value) {
      setState(() {
        snapshot = value;
        if (snapshot != null) {
          if (snapshot!.get("profileImage") != "null") {
            profileImageData = snapshot!.get("profileImage");
          }
        }
      });
    });
  }

  var data = [
    {'category': 'Lokasyon', 'sales': 0},
  ];

  void lokasyonListesiCek() {
    LokasyonDatabase.instance.readAllLokasyonlar().then((value) {
      setState(() {
        data = [
          {'category': 'Lokasyon', 'sales': value.length},
        ];
      });
    });
  }

  FutureOr geriDonusTespiti(dynamic value) {
    kullaniciVeriCek();
    lokasyonListesiCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.white,
        titleSpacing: -4.0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_pin_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Profil Detayı",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ))
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: Icon(
                Icons.edit_location_sharp,
                color: Colors.red.withOpacity(0.75),
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilDuzenle(profileImageData!, snapshot!)))
                    .then(geriDonusTespiti);
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    child: profileImageData == "null"
                        ? Image.asset("assets/images/avatar.png")
                        : SizedBox(
                            child: ClipRRect(
                            child: Image.memory(
                              base64Decode(profileImageData!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                          )),
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                child: Text(
                  snapshot == null ? "" : snapshot!.get("userName"),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Icon(
                    Icons.mail,
                    color: Colors.red.withOpacity(0.75),
                  ),
                ),
                minLeadingWidth: 0,
                title: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  snapshot == null ? "" : snapshot!.get("email"),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Icon(
                    Icons.add_location_alt,
                    color: Colors.red.withOpacity(0.75),
                  ),
                ),
                minLeadingWidth: 0,
                title: Text(
                  "Eklenen Toplam Lokasyon",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 140,
                    child: Chart(
                      data: data,
                      variables: {
                        'category': Variable(
                          accessor: (Map map) => map['category'] as String,
                        ),
                        'sales': Variable(
                          accessor: (Map map) => map['sales'] as num,
                        ),
                      },
                      elements: [IntervalElement()],
                      axes: [
                        Defaults.horizontalAxis,
                        Defaults.verticalAxis,
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Icon(
                    Icons.date_range,
                    color: Colors.red.withOpacity(0.75),
                  ),
                ),
                minLeadingWidth: 0,
                title: Text(
                  "Hesap Oluşturma Tarihi",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  snapshot == null ? "" : snapshot!.get("createDate"),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Icon(
                    Icons.password,
                    color: Colors.red.withOpacity(0.75),
                  ),
                ),
                minLeadingWidth: 0,
                title: Text(
                  "Şifre",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                subtitle: Text(
                  snapshot == null ? "" : snapshot!.get("password"),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CikisOnayi()));
                      },
                      color: Colors.red.withOpacity(.75),
                      elevation: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Çıkış",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
