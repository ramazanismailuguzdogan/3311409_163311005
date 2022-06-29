import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:gezdunyayigorkonyayi/db/kullaniciDb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfilDuzenle extends StatefulWidget {
  String? profileImageData = "null";
  DocumentSnapshot? snapshotData;

  ProfilDuzenle(String profileImage, DocumentSnapshot snapshot, {Key? key})
      : super(key: key) {
    this.profileImageData = profileImage;
    this.snapshotData = snapshot;
  }

  @override
  State<ProfilDuzenle> createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  AuthService _authService = AuthService();

  ImagePicker picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  @override
  initState() {
    super.initState();
    _usernameController.text =
        widget.snapshotData == null ? "" : widget.snapshotData!.get("userName");
    _passwordController.text =
        widget.snapshotData == null ? "" : widget.snapshotData!.get("password");
    _repasswordController.text =
        widget.snapshotData == null ? "" : widget.snapshotData!.get("password");
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
                child: Stack(
                  children: [
                    Container(
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
                          shape: BoxShape.circle),
                      child: SizedBox(
                        child: widget.profileImageData == "null"
                            ? Image.asset("assets/images/avatar.png")
                            : SizedBox(
                                child: ClipRRect(
                                child: Image.memory(
                                  base64Decode(widget.profileImageData!),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                              )),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,maxHeight: 480, maxWidth: 480);
                          final bytes = File(image!.path).readAsBytesSync();
                          String base64Image = base64Encode(bytes);
                          setState(() {
                            widget.profileImageData = base64Image;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Kullanıcı Adı",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Bu alana Yazınız",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Şifre",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Bu alana yazınız",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _repasswordController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Şifre Tekrarı",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Bu alana yazınız",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      onPressed: () {
                        _authService
                            .updatePerson(
                                _usernameController.text,
                                widget.snapshotData == null
                                    ? ""
                                    : widget.snapshotData!.get("email"),
                                widget.snapshotData! == null
                                    ? ""
                                    : widget.snapshotData!.get("password"),
                                _passwordController.text,
                                widget.profileImageData.toString(),
                                widget.snapshotData == null
                                    ? ""
                                    : widget.snapshotData!.get("createDate"))
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      color: Colors.red.withOpacity(.75),
                      elevation: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_location_sharp,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Güncelle",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
