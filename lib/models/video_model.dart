import 'package:yt_download/models/id_model.dart';
import 'package:yt_download/models/thumbnail_model.dart';

class Video {
  Id id;
  Snippet snippet;

  Video({required this.id, required this.snippet});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: Id.fromJson(json['id']),
      snippet: Snippet.fromJson(json['snippet'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id.toJson(),
    'snippet': snippet.toJson()
  };
}

class Snippet {
  String? title;
  String? description;
  String? channelTitle;
  Thumbnail thumbnail;

  Snippet({
    this.title,
    this.description,
    this.channelTitle,
    required this.thumbnail,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
      title: json['title'],
      description: json['description'],
      channelTitle: json['channelTitle'],
      thumbnail: Thumbnail.fromJson(json['thumbnails']),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'channelTitle': channelTitle,
        'thumbnails': thumbnail.toJson()
      };
}
