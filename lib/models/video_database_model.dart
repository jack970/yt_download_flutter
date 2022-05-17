class VideoDatabase {
  String videoId;
  String? kind;
  String? title;
  String? description;
  String? channelTitle;
  String? url;
  int? width;
  int? height;

  VideoDatabase({
    required this.videoId,
    this.kind,
    this.title,
    this.description,
    this.channelTitle,
    this.url,
    this.width,
    this.height,
  });

  factory VideoDatabase.fromJson(Map<String, dynamic> json) {
    return VideoDatabase(
      videoId: json['videoId'],
      kind: json['kind'],
      title: json['title'],
      description: json['description'],
      channelTitle: json['channelTitle'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() => {
    'videoId': videoId,
    'kind': kind,
    'title': title,
    'description': description,
    'channelTitle': channelTitle,
    'url': url,
    'width': width,
    'height': height
  };
}
