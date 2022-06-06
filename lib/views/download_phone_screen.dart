import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:yt_download/controllers/download_controller.dart';
import 'package:yt_download/controllers/video_titulo_controller.dart';
import 'package:yt_download/views/VideoPlayerScreen.dart';

class DownloadPhoneScreen extends StatefulWidget {
  const DownloadPhoneScreen({Key? key}) : super(key: key);

  @override
  State<DownloadPhoneScreen> createState() => _DownloadPhoneScreenState();
}

class _DownloadPhoneScreenState extends State<DownloadPhoneScreen> {
  List _listFiles = [];
  String _download_path = 'Download';

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    _listFiles = await DownloadController().getFilesFromPath(_download_path);
    // print(_listFiles);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloads"),
      ),
      body: _listFiles.isEmpty
          ? Center(
              child: notFound(
                  "Nada encontrado!", "Baixe algo para ser mostrado aqui."))
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: _listFiles.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _listFiles;
                // File file = item[index];
                // return fileItemWidget(file);
                return Text(item[index].toString());
              }),
    );
  }

  iconeDoArquivo(String filename) {
    final tipo_arquivo = VideoTituloController.detectaTipoArquivo(filename);

    if (tipo_arquivo == 'mp4') {
      return Icons.video_collection;
    } else if (tipo_arquivo == 'mp3') {
      return Icons.audiotrack_rounded;
    } else {
      return Icons.insert_drive_file;
    }
  }

  Card fileItemWidget(File file) {
    final videoTitle = path.basename(file.path);
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      videoPath: file,
                      videoTitle: videoTitle,
                    )),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              iconeDoArquivo(file.path),
              size: 100,
            ),
            Text(
              videoTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget notFound(titulo, descricao) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.warning_rounded,
            size: 100,
            color: Colors.redAccent,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            titulo ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(descricao ?? "")
        ],
      ),
    );
  }
}
