import 'dart:io';

import 'package:naser_alqtami/core/api/end_points.dart';
import 'package:path_provider/path_provider.dart';

abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
  Future<Map<String, String>> fetchAnotherSong(int index);
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist() async {
//  final allSura = BlocProvider.of<QuranSurCubit>(context).quranSur;
//     List<Map<String, String>> surasList = [];
//     surasList.clear();
//  if(allSura!=null) {
//    for (var i = 0; i < allSura.allQuran.length; i++) {
//       surasList.add(_nextSong(allSura.allQuran[i], i));
//     }
//  }
//     return surasList;
    return List.generate(114, (index) => _nextSong(index + 1));
  }

  // var _songIndex = 0;
  // static const _maxSongNumber = 16;

  // Map<String, String> _nextSong() {
  //   _songIndex = (_songIndex % _maxSongNumber) + 1;
  //   return {
  //     'id': _songIndex.toString().padLeft(3, '0'),
  //     'title': 'Song $_songIndex',
  //     'album': 'SoundHelix',
  //     'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$_songIndex.mp3',
  //   };
  // }

  getAppBaths() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    return appDocDirectory.path;
  }

  Map<String, String> _nextSong(int index) {
    String songIndex = index.toString().padLeft(3, '0');

    return {
      'id': songIndex,
      'title': 'سورة $index',
      'album': 'ناصر القطامي',
      'url': "${EndPoints.quranAudio + songIndex}.mp3",
      'path':'$getAppBaths/$songIndex.mp3'
    };
  }

  @override
  Future<Map<String, String>> fetchAnotherSong(int index) {
    throw UnimplementedError();
  }
}
