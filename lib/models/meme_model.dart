class MemeModel {
  bool success;
  Data data;
  
  MemeModel({required this.success, required this.data});
  factory MemeModel.fromJson(Map<String, dynamic> json){
    return MemeModel(
      success: json['success'],
      data: Data.fromJson(json['data'])
    );
    
  }
}


class Data{
  List<Meme> memes = <Meme>[];
  


  Data.fromJson(Map<String, dynamic> json) {
      memes = (json["memes"] as List).map((e) => Meme.fromJson(e)).toList();
  
  }






}


class Meme {
  String id;
  String name;
  String url;
  int width;
  int height;
  int boxCount;
  int captions;

  Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
    required this.captions,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json["id"] as String,
      name: json["name"] as String,
      url: json["url"] as String,
      width: json["width"] as int,
      height: json["height"] as int,
      boxCount: json["box_count"] as int,
      captions: json["captions"] as int,
    );
  }
}
