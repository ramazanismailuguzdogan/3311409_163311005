import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ViewIletisim extends StatelessWidget {
  final textKonuController = TextEditingController();
  final textMesajController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İletişim"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "Lütfen Aşağıdaki Kısma Göndermek İstediğiniz Mesajı Giriniz.",
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
                      controller: textKonuController,
                      decoration: InputDecoration(
                        hintText: 'Konu',
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
                      controller: textMesajController,
                      maxLines: 8, //or null
                      decoration: InputDecoration.collapsed(
                        hintText: 'Mesajınızı bu alana yazınız...',
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
                                Share.share(textMesajController.text, subject: textKonuController.text);
                              },
                              borderRadius: BorderRadius.circular(10.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Mesajı Gönder",
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
    );
  }
}
