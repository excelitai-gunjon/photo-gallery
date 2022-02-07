
class PhotosList {
  final List<PhotoDataModel>? photos;

  PhotosList({
    this.photos,
  });

  factory PhotosList.fromJson(List<dynamic> parsedJson) {

    List<PhotoDataModel> productList = parsedJson.map((i) => PhotoDataModel.fromJson(i)).toList();
    return PhotosList(
      photos: productList,
    );

  }
}


class PhotoDataModel {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  PhotoDataModel(
      {this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.downloadUrl});

  factory PhotoDataModel.fromJson(Map<String, dynamic> json) {
    return PhotoDataModel(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      downloadUrl: json['download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}
