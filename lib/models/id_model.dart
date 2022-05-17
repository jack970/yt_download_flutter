class Id {
  String id;
  String kind;

  Id({ required this.id, required this.kind });

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(id: json['videoId'], kind: json['kind']);
  }

  Map<String, dynamic> toJson() => {
    'videoId': id,
    'kind': kind
  };
}