import 'package:coursati/Classes/GlobalVariables.dart';

class BoxCourseLabelData {
  BoxCourseLabelData(
      {required this.location_in,
      required this.name,
      required this.image,
      required this.id});
  String? location_in;
  String? name;
  String? image;
  String? id;

  BoxCourseLabelData.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    name = json["name"];
    image = serverStorage + json["image"];
    location_in = json["location_in"];
  }

  Map<String, dynamic> toJson() =>
      {'id': id, "name": name, "image": image, "location_in": location_in};
}
