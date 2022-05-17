class Thumbnail {
  Thumbnails thumbnails;

  Thumbnail({required this.thumbnails});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      thumbnails: Thumbnails.fromJson(json['medium']),
    );
  }

  Map<String, dynamic> toJson() => {
    'medium' : thumbnails.toJson(),
  };
}

class Thumbnails {
  String? url;
  int? width;
  int? height;

  Thumbnails({
    this.url,
    this.width,
    this.height,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    return Thumbnails(
        url: json['url'],
        width: json['width'],
        height: json['height']
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'width': width,
    'height': height,
  };
}
