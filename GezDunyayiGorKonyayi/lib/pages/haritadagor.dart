import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gezdunyayigorkonyayi/model/lokasyon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HaritadaGor extends StatelessWidget {
  Lokasyon? lokasyonData;

  HaritadaGor({required Lokasyon lokasyon, Key? key}) : super(key: key) {
    this.lokasyonData = lokasyon;
  }

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haritada Gör"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(lokasyonData!.dataLat),
              double.parse(lokasyonData!.dataLon)),
          zoom: 14.4746,
        ),
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        markers: {
          Marker(
              markerId: MarkerId(
                "lokasyon" + lokasyonData!.id.toString(),
              ),
              position: LatLng(double.parse(lokasyonData!.dataLat),
                  double.parse(lokasyonData!.dataLon)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            lokasyonData!.baslik,
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
                                            lokasyonData!.aciklama,
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
                                            lokasyonData!.ani,
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
                                            double.parse(lokasyonData!.puan),
                                        minRating:
                                            double.parse(lokasyonData!.puan),
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
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
