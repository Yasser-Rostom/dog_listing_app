import 'package:dog_listing_app/core/local_storage.dart';

import '../models/breed_image.dart';

abstract class BreedLocalDataSource {
  Future<List<String>?> getAllFavBreedNames();
  Future<List<String>?> getFavBreedImages(String breedName);
  Future<bool> removeFav(String breedName);
  Future<bool> cacheFav(BreedWithImagesLocalModel model);
}

class BreadLocalDataSourceImpl implements BreedLocalDataSource{

  final dbHelper = DatabaseHelper();
  @override
  Future<List<String>?> getAllFavBreedNames() async {
   final list= await dbHelper.fetchFavoriteBreedNames();
   return list;
  }


  Future<bool> removeFav(String breedName) async {

    //should return 1;
   bool numberOfDeleted= await dbHelper.delete(breedName) >0? true: false;
    return numberOfDeleted;
  }

  @override
  Future<bool> cacheFav(BreedWithImagesLocalModel model) async {
   return await dbHelper.addFav(model)> 0? true: false;
  }

  @override
  Future<List<String>?> getFavBreedImages(String breedName) async {
    final list= await dbHelper.fetchFavBreedImages(breedName);
    return list;
  }
}