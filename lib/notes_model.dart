class NotesModel {
  String? title;
  String? description;
  String? id;
  String? updation;

  NotesModel({this.title, this.description, this.id, this.updation});

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        title: json["title"],
        description: json["description"],
        id: json["id"],
        updation: json["updation"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "id": id,
        "updation": updation,
      };
}

/**
 * {
  "title": "Welcome to quicktype!",
  "description":"Testing"
}
 */
