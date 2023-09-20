
import '../../domain/entities/breed.dart';

class BreedModel {
  List<Breed?>? bread;
  String? status;

  BreedModel({this.bread, this.status});
  //
  // BreadModel.fromJson(Map<String, dynamic> json) {
  //   bread =
  //   json['message'] != null ?  List<Bread.fromJson(json['message']> : null;
  //   status = json['status'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (bread != null) {
  //     data['message'] = bread!.toJson();
  //   }
  //   data['status'] = status;
  //   return data;
 }
