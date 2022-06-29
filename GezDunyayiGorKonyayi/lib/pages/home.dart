import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/views/anasayfa.dart';
import 'package:gezdunyayigorkonyayi/views/haberler.dart';
import 'package:gezdunyayigorkonyayi/views/iletisim.dart';
import 'package:gezdunyayigorkonyayi/views/profil.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _secilenSayfa = 0;
  final _widgetOptions = [
    ViewAnasayfa(),
    ViewHaberler(),
    ViewIletisim(),
    ViewProfil()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: _widgetOptions[_secilenSayfa],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(
                  Icons.home,
                  size: 22,
                ),
              ),
              label: 'Anasayfa',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(
                  Icons.newspaper,
                  size: 22,
                ),
              ),
              label: 'Haberler',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(
                  Icons.mail_outline,
                  size: 22,
                ),
              ),
              label: 'İletişim',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(
                  Icons.person_outline,
                  size: 22,
                ),
              ),
              label: 'Profil',
            ),
          ],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          iconSize: 21.0,
          currentIndex: _secilenSayfa,
          onTap: (int index) {
            if (_secilenSayfa != index) {
              setState(() {
                _secilenSayfa = index;
              });
            }
          },
        ),
      ),
    );
  }
}
