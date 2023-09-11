
class Jsondata {
  Jsondata({
    required this.id,
    required this.title,
    required this.description,
  });

  String id;
  String title;
  String description;


  factory Jsondata.fromJson(Map<String, dynamic> json) => Jsondata(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
  };
}
