import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yt_download/components/showDialogOk.dart';
import 'package:yt_download/controllers/request_from_server.dart';

class DownloadController {
  static createFolderInApp(String foldername) async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    final dirname = path.join(_appDocDir.path, foldername);

    final Directory _appDocDirFolder =
        Directory(dirname);

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  Future<List> getFilesFromPath(String foldername) async {
    Directory? directory;
    String newPath = "";

    if(await _requestPermission(Permission.storage)) {
      directory = await getExternalStorageDirectory();
      List<String> folders = directory!.path.split('/');
      for (String folder in folders) {
        if (folder != "Android") {
          newPath += "$folder/";
        } else {
          break;
        }
      }
      newPath = newPath+foldername;
      directory = Directory(newPath);
      return directory.listSync();
    } else {
      return [];
    }
      // final Directory _appDocDir = await getApplicationDocumentsDirectory();
      //
      // final dirname = path.join(_appDocDir.path, foldername);
      // final Directory _appDocDirFolder = Directory(dirname);
      // return _appDocDirFolder.listSync();
  }


  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if(result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  static realizaDownload(context, videoId, videoTitle, format) {
    ComunnicationAPI _comunnicationAPI = ComunnicationAPI();

    _comunnicationAPI.api.hasNetwork().then((value) {
      if (!value) {
        return showAlertDialogOk(
            "Sem Internet!", "Tente novamente mais tarde.", context);
      }
    });
    _comunnicationAPI.downloadFile(videoId, videoTitle, format);
  }
}
