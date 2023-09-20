class BreedWithImagesLocalModel {
  final String breedName;
  final List<String> imageList;

  BreedWithImagesLocalModel({required this.breedName, required this.imageList});

  factory BreedWithImagesLocalModel.fromJson(Map<String, dynamic> map) {
    return BreedWithImagesLocalModel(
        breedName: map["breed_name"], imageList: map["image_url"]);
  }
}
