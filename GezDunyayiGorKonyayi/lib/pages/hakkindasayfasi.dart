import 'package:flutter/material.dart';

class HakkindaSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Hakkında"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
              ),
              height: 160,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 160,
                  width: 160,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
            ),
            Text(
              "Gez Dünya'yı Gör Konya'yı",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Divider(
              height: 40,
            ),
            Text(
              "Uygulamanın Amacı",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Uygulamayı yapma amacımız  gittiğimiz yerleri not olarak alıp hakkında bilgi sahibi olup önceden gezdiğimiz yerleri unutmamak için ve  canımız sıkıldığında  da zaman geçirmemiz için günlük haber yapılan uygulamadır.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
            ),
            Divider(
              height: 40,
            ),
            Text(
              "İletişim",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "uguzdogan34@gmail.com",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
