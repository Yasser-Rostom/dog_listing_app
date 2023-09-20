

abstract class  BreedRepo{
  //to list all breeds
List<String>getAllFavBreedNames();
List<String>getAllBreedNames();

List<String>getFavBreedImages();
List<String>getBreedImages();

//to add a dog to the favorite local db
Future<String> addFavToLocalDb();

//to remove a dog from the favorite local db
Future<int> removeFavFromLocalDb();

}