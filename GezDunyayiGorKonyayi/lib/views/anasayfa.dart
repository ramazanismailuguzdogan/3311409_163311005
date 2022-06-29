import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:gezdunyayigorkonyayi/db/lokasyonDb.dart';
import 'package:gezdunyayigorkonyayi/model/lokasyon.dart';
import 'package:gezdunyayigorkonyayi/pages/hakkindasayfasi.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonekle.dart';
import 'package:gezdunyayigorkonyayi/pages/lokasyonlistesi.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewAnasayfa extends StatefulWidget {
  const ViewAnasayfa({Key? key}) : super(key: key);

  @override
  State<ViewAnasayfa> createState() => _ViewAnasayfaState();
}

class _ViewAnasayfaState extends State<ViewAnasayfa> {
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.0286349, 32.5071287),
    zoom: 14.4746,
  );
  GoogleMapController? mapController;

  final Set<Marker> mapMarkerList = new Set();

  List<Lokasyon> lokasyonListesi = [];

  @override
  initState() {
    super.initState();
    lokasyonListesiCek();
  }

  void lokasyonListesiCek() {
    LokasyonDatabase.instance.readAllLokasyonlar().then((value) {
      lokasyonListesi = value;
      value.forEach((element) {
        setState(() {
          mapMarkerList.add(
            Marker(
                markerId: MarkerId(
                  "lokasyon" + element.id.toString(),
                ),
                position: LatLng(double.parse(element.dataLat),
                    double.parse(element.dataLon)),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              // height: 300,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(14),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Lokasyon Bilgisi",
                                          style: TextStyle(
                                            fontFamily: "Roboto-Bold",
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 320,
                                          child: Divider(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Başlık:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              element.baslik,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 320,
                                          child: Divider(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Açıklama:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              element.aciklama,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 320,
                                          child: Divider(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Anı:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              element.ani,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 320,
                                          child: Divider(),
                                        ),
                                        RatingBar.builder(
                                          initialRating:
                                              double.parse(element.puan),
                                          minRating: double.parse(element.puan),
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 10,
                                          itemSize: 20,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: ClipOval(
                                      child: Material(
                                        color: Colors.grey
                                            .withOpacity(0.2), // Button color
                                        child: InkWell(
                                          // Splash color
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            width: 26,
                                            height: 26,
                                            child: Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.black54,
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
                      );
                    },
                  );
                }),
          );
        });
      });
    });
  }

  FutureOr geriDonusTespiti(dynamic value) {
    lokasyonListesiCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getMyLocation().then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => LokasyonEkle(
                          konum: value,
                        ))).then(geriDonusTespiti);
          });
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            markers: mapMarkerList,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          Positioned(
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () async {
                getMyLocation().then((value) async {
                  await mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: value,
                        zoom: 17,
                        tilt: 45,
                        bearing: 0,
                      ),
                    ),
                  );
                });
              },
              child: Icon(Icons.my_location),
            ),
            bottom: 15,
            left: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HakkindaSayfasi()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4)),
                      width: 90,
                      child: Row(
                        children: [
                          Icon(Icons.info),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Hakkında",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                        contentPadding: EdgeInsets.only(left: 15),
                        horizontalTitleGap: 8,
                        title: Text(
                          "Gez Dünyayı Gör Konya'yı",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LokasyonListesi()))
                                .then(geriDonusTespiti);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(4)),
                            width: 75,
                            child: Row(
                              children: [
                                Icon(Icons.not_listed_location_sharp,
                                    color: Colors.white),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Yerler",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Future<LatLng> getMyLocation() async {
    LatLng latlng = new LatLng(38.0286349, 32.5071287);
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      latlng = new LatLng(position.latitude, position.longitude);
    });
    return latlng;
  }
}
