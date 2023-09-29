// To parse this JSON data, do
//
//     final allQuranSur = allQuranSurFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/quran_surh.dart';

AllQuranSurModel allQuranSurFromJson(String str) => AllQuranSurModel.fromJson(json.decode(str));

class AllQuranSurModel extends AllQuranSur {
 

  const AllQuranSurModel({
    required List<AllQuran> surah,
  }) : super(allQuran: surah);

  factory AllQuranSurModel.fromJson(Map<String, dynamic> json) => AllQuranSurModel(
        surah: List<AllQuran>.from(json["all_quran"].map((x) => AllQuran.fromJson(x))),
      );
}



class AllQuran {
  final String type;
  final int count;
  final String title;
  final String titleAr;
  final String index;
  final List<Juz> juz;

  AllQuran({
    required this.type,
    required this.count,
    required this.title,
    required this.titleAr,
    required this.index,
    required this.juz,
  });

  factory AllQuran.fromJson(Map<String, dynamic> json) => AllQuran(
        type: json["type"],
        count: json["count"],
        title: json["title"],
        titleAr: json["titleAr"],
        index: json["index"],
        juz: List<Juz>.from(json["juz"].map((x) => Juz.fromJson(x))),
      );
}

class Juz {
  final String index;

  Juz({
    required this.index,
  });

  factory Juz.fromJson(Map<String, dynamic> json) => Juz(
        index: json["index"],
      );
}
