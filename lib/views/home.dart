import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yt_download/components/customAppBar.dart';
import 'package:yt_download/components/listview_videos.dart';
import 'package:flutter/services.dart';
import 'package:yt_download/components/showDialogOk.dart';
import 'package:yt_download/controllers/download_controller.dart';
import 'package:yt_download/controllers/request_from_server.dart';
import 'package:yt_download/models/video_model.dart';
import 'package:yt_download/providers/db_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ComunnicationAPI _comunnicationAPI = ComunnicationAPI();
  Future<List>? _videos;
  final TextEditingController _controller = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _videos = readJson();
    });
    DownloadController.createFolderInApp('Downloads');
  }

  searchVideosFromApi(String searchString) {
    if (searchString.isEmpty) {
      return showAlert();
    }
    setState(() {
      _videos = _comunnicationAPI.requestListVideosFromServer(searchString);
    });
  }

  showAlert() {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("O campo de pesquisa está vazio"),
          );
        });
  }

  Future<List<Video>> readJson() async {
    final response = await rootBundle.loadString('assets/data.json');
    final list = json.decode(response) as List<dynamic>;

    return list.map((e) {
      Video video = Video.fromJson(e);
      DBProvider.db.createVideoContents(video);
      return video;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        CustomAppBar(
          title: widget.title,
          isSearching: isSearching,
          controller: _controller,
          onSubmitted: (String value) {
            _comunnicationAPI.api.hasNetwork().then((hasNetwork) {
              if (!hasNetwork) {
                return showAlertDialogOk(
                    "Sem Internet!", "Tente novamente mais tarde.", context);
              }
              searchVideosFromApi(value);
            });
          },
          setIsSearching: () {
            setState(() {
              isSearching = !isSearching;
            });
          },
        ),
        SliverFillRemaining(
          child: ListViewVideos(
            videos: _videos,
          ),
        )
      ]),
      drawer: menuDrawer(),
    );
  }

  Drawer menuDrawer() {
    return Drawer(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 70, left: 40, bottom: 30),
              width: double.infinity,
              color: Colors.red,
              child: Text(
                "MENU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.download_rounded),
              title: Text("Downloads"),
              onTap: () => Navigator.popAndPushNamed(context, '/Downloads'),
            ),
          ],
        ),
      ),
    );
  }
}
