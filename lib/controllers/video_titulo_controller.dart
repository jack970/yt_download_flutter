import 'package:yt_download/components/dialogDownload.dart';

class VideoTituloController {
  static String encurtaTitulo(String titulo, int tamanhoString) {
    if (titulo.length > tamanhoString) {
      return titulo.substring(0, tamanhoString);
    } else {
      return titulo;
    }
  }

  static String tipoArquivoTitulo(TipoDeArquivo tipoDeArquivo) {
    const fileMP4 = 'mp4';
    const fileMP3 = 'mp3';

    if (tipoDeArquivo == TipoDeArquivo.video) {
      return fileMP4;
    } else {
      return fileMP3;
    }
  }

  static String excluiTipoArquivoTitulo(String titulo) {
    const listProps = ['.mp3', '.mp4', '.jpeg', '.jpg'];

    for (String prop in listProps) {
      titulo = titulo.split(prop).join();
    }
    return titulo.trim();
  }

  static detectaTipoArquivo(String filename) {
    const listProps = ['jpeg', 'mp4', 'mp3', 'jpg'];
    final propFilename = filename.split('.').last;

    String propFound = '';
    for (String prop in listProps) {
      if (propFilename.contains(prop)) {
        propFound = prop;
      }
    }
    return propFound;
  }
}