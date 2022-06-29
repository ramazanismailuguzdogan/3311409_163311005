import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';

final String tableLokasyonlar = 'lokasyonlar';

class LokasyonFields {
  static final List<String> values = [
    id,
    baslik,
    aciklama,
    ani,
    puan,
    dataLat,
    dataLon,
    tarih
  ];

  static final String id = '_id';
  static final String baslik = 'baslik';
  static final String aciklama = 'aciklama';
  static final String ani = 'ani';
  static final String puan = 'puan';
  static final String dataLat = 'dataLat';
  static final String dataLon = 'dataLon';
  static final String tarih = 'tarih';
}

class Lokasyon {
  final int? id;
  final String baslik;
  final String aciklama;
  final String ani;
  final String puan;
  final String dataLat;
  final String dataLon;
  final DateTime tarih;

  const Lokasyon({
    this.id,
    required this.baslik,
    required this.aciklama,
    required this.ani,
    required this.puan,
    required this.dataLat,
    required this.dataLon,
    required this.tarih,
  });

  Lokasyon copy({
    int? id,
    String? baslik,
    String? aciklama,
    String? ani,
    String? puan,
    String? dataLat,
    String? dataLon,
    DateTime? tarih,
  }) =>
      Lokasyon(
        id: id ?? this.id,
        baslik: baslik ?? this.baslik,
        aciklama: aciklama ?? this.aciklama,
        ani: ani ?? this.ani,
        puan: puan ?? this.puan,
        dataLat: dataLat ?? this.dataLat,
        dataLon: dataLon ?? this.dataLon,
        tarih: tarih ?? this.tarih,
      );

  static Lokasyon fromJson(Map<String, Object?> json) => Lokasyon(
        id: json[LokasyonFields.id] as int?,
        baslik: json[LokasyonFields.baslik] as String,
        aciklama: json[LokasyonFields.aciklama] as String,
        ani: json[LokasyonFields.ani] as String,
        puan: json[LokasyonFields.puan] as String,
        dataLat: json[LokasyonFields.dataLat] as String,
        dataLon: json[LokasyonFields.dataLon] as String,
        tarih: DateTime.parse(json[LokasyonFields.tarih] as String),
      );

  Map<String, Object?> toJson() => {
        LokasyonFields.id: id,
        LokasyonFields.baslik: baslik,
        LokasyonFields.aciklama: aciklama,
        LokasyonFields.ani: ani,
        LokasyonFields.puan: puan,
        LokasyonFields.dataLat: dataLat,
        LokasyonFields.dataLon: dataLon,
        LokasyonFields.tarih: tarih.toIso8601String(),
      };
}
