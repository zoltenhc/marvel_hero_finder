class Comics {
  final int available;

  Comics({this.available});

  factory Comics.fromJson(Map<String, dynamic> json) =>
      Comics(available: json['available']);
}

class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({this.path, this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    path: json['path'],
    extension: json['extension'],
  );
}

class Results {
  final int id;
  final String name;
  final String description;
  Thumbnail thumbnail;
  Comics comics;

  Results({this.id, this.name, this.description, this.thumbnail, this.comics});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
      comics: Comics.fromJson(json['comics']));
}

class Data {
  final int count;
  List<Results> results;

  Data({this.count, this.results});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Results> resultsList = list.map((e) => Results.fromJson(e)).toList();

    return Data(
      count: json['count'],
      results: resultsList,
    );
  }
}

class MarvelData {
  final int code;
  Data data;

  MarvelData({this.code, this.data});

  factory MarvelData.fromJson(Map<String, dynamic> json) =>
      MarvelData(code: json['code'], data: Data.fromJson(json['data']));
}
