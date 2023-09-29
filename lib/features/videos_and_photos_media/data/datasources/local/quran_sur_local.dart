import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/quran_sur_model.dart';

abstract class QuranSurLocalDataSource {
  Future<AllQuranSurModel> getQuranSur();
}

class QuranSurLocalDataSourceImpl implements QuranSurLocalDataSource {
  QuranSurLocalDataSourceImpl();

  @override
  Future<AllQuranSurModel> getQuranSur() async {
    try {
      final response = await rootBundle.loadString('assets/json/quran.json');
      var responseList = await json.decode(response.toString());
      return AllQuranSurModel.fromJson(responseList);
    } catch (e) {
      debugPrint("readquranJson error=========${e.toString()}");
      throw const CacheException();
    }
  }

 
}
