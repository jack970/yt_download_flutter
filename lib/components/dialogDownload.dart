import 'package:flutter/material.dart';
import 'package:yt_download/controllers/download_controller.dart';
import '../controllers/video_titulo_controller.dart';

enum TipoDeArquivo { video, audio }

class DialogDownload extends StatefulWidget {
  final String videoTitulo;
  final String? videoId;

  const DialogDownload({Key? key, this.videoTitulo = "", this.videoId})
      : super(key: key);

  @override
  State<DialogDownload> createState() => _DialogDownloadState();
}

class _DialogDownloadState extends State<DialogDownload> {
  TipoDeArquivo _tipoDeArquivo = TipoDeArquivo.video;
  final _controller = TextEditingController();

  @override
  void initState() {
    setState(() {
      _controller.text = trataTituloVideo(widget.videoTitulo, _tipoDeArquivo);
    });
  }

  String trataTituloVideo(String titulo, TipoDeArquivo tipoDeArquivo) {
    String tituloEncurtado = VideoTituloController.encurtaTitulo(titulo, 30);
    String excluiTipoArquivoTitulo =
        VideoTituloController.excluiTipoArquivoTitulo(tituloEncurtado);
    String formato = VideoTituloController.tipoArquivoTitulo(tipoDeArquivo);

    return "$excluiTipoArquivoTitulo.$formato";
  }

  Widget RadioButton(
      {String? titulo,
      required TipoDeArquivo tipoValue,
      Function(TipoDeArquivo?)? onChanged}) {
    return Row(
      children: [
        Radio<TipoDeArquivo>(
          value: tipoValue,
          groupValue: _tipoDeArquivo,
          onChanged: onChanged,
        ),
        Text(titulo ?? ""),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.videoTitulo);
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: AppBar(
        title: Text("Download"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String formato = VideoTituloController.tipoArquivoTitulo(_tipoDeArquivo);
              DownloadController.realizaDownload(
                  context,
                  widget.videoId,
                  _controller.text,
                  formato
              );
            },
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onTap: () {},
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Nome do arquivo",
              hintText: 'Insira o nome do arquivo',
            ),
          ),
          Row(
            children: [
              RadioButton(
                  titulo: "Vídeo",
                  tipoValue: TipoDeArquivo.video,
                  onChanged: (value) {
                    setState(() {
                      if (widget.videoTitulo.isNotEmpty) {
                        _controller.text =
                            trataTituloVideo(widget.videoTitulo, value!);
                        _tipoDeArquivo = value;
                      }
                    });
                  }),
              RadioButton(
                  titulo: "Audio",
                  tipoValue: TipoDeArquivo.audio,
                  onChanged: (value) {
                    setState(() {
                      if (widget.videoTitulo.isNotEmpty) {
                        _controller.text =
                            trataTituloVideo(widget.videoTitulo, value!);
                        _tipoDeArquivo = value;

                        // DownloadController.realizaDownload(
                        //   context,
                        //   widget.videoId,
                        //   _controller.text,
                        //   'mp3'
                        // );
                      }
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
