class DataModel {
  int? id;
  String name;

  DataModel({this.id, required this.name});

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      DataModel(name: json['name'], id: json['id']);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name
      };
}
