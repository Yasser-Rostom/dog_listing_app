
import '../../domain/repository/breed_repo.dart';
import '../datasources/breed_api_datasource.dart';

//this could be implemented later
class BreedRepoImpl extends BreedRepo{
  @override
  Future<String> addFavToLocalDb() {
    // TODO: implement addFavToLocalDb
    throw UnimplementedError();
  }

  @override
  List<String> getAllBreedNames() {
    // TODO: implement getAllBreedNames
    throw UnimplementedError();
  }

  @override
  List<String> getAllFavBreedNames() {
    // TODO: implement getAllFavBreedNames
    throw UnimplementedError();
  }

  @override
  List<String> getBreedImages() {
    // TODO: implement getBreedImages
    throw UnimplementedError();
  }

  @override
  List<String> getFavBreedImages() {
    // TODO: implement getFavBreedImages
    throw UnimplementedError();
  }

  @override
  Future<int> removeFavFromLocalDb() {
    // TODO: implement removeFavFromLocalDb
    throw UnimplementedError();
  }

}