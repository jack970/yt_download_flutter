import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yt_download/components/dialogDownload.dart';
import 'package:yt_download/models/video_model.dart';

class ListViewVideos extends StatelessWidget {
  const ListViewVideos({Key? key, this.videos}) : super(key: key);
  final Future<List>? videos;

  Widget videoMenu(videoId, videoTitle) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            minLeadingWidth: 0,
            leading: const Icon(Icons.download_rounded),
            title: const Text('Baixar'),
            onTap: () async {
              Navigator.pop(context);
              return showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return DialogDownload(
                      videoTitulo: videoTitle,
                      videoId: videoId,
                    );
                  });
              // _comunnicationAPI.api.hasNetwork().then((value) {
              //   if (!value) {
              //     return showAlertDialogOk(
              //         "Sem Internet!", "Tente novamente mais tarde.", context);
              //   }
              // });
              // _comunnicationAPI.downloadFile(videoId, videoTitle);
            },
          ),
        ),
      ],
    );
  }

  Widget videoItem({required Video item, context}) {
    final thumbnail = item.snippet.thumbnail.thumbnails;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              thumbnail.url.toString(),
              frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: frame != null
                      ? child
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator(strokeWidth: 6),
                          ),
                        ),
                );
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          item.snippet.title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      videoMenu(item.id.id, item.snippet.title)
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item.snippet.description.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: videos,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        late Widget children;
        if (snapshot.hasData) {
          List data = snapshot.data;
          if (data.isEmpty) {
            children = const Center(
              child: Text("Pesquise videos para mostrar na listView"),
            );
          } else {
            children = ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                itemCount: data.length,
                itemBuilder: (context, int index) {
                  Video item = data[index];
                  return videoItem(item: item, context: context);
                });
          }
        } else if (snapshot.hasError) {
          print(snapshot.error);
          children = Text("${snapshot.error}");
        } else if (!snapshot.hasData) {
          children = const Center(
            child: CircularProgressIndicator(),
          );
        }
        return children;
      },
    );
  }
}
