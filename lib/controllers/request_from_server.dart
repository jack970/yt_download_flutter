import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:yt_download/models/video_model.dart';
import 'package:yt_download/providers/api.dart';
import 'package:yt_download/providers/db_provider.dart';

class ComunnicationAPI {
  API api = API();

  Future<List> requestListVideosFromServer(String searchString) async {
    DBProvider.db.deleteAllVideoContents();

    final response = await api.get("search/$searchString");

    return response.map((e) {
      Video video = Video.fromJson(e);
      DBProvider.db.createVideoContents(video);
      return video;
    }).toList();
  }

  Future<File> downloadFile(String id, String filename) async {
    Uint8List response = await api.getVideo('download/$id');

    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(response);
    return file;
  }
}