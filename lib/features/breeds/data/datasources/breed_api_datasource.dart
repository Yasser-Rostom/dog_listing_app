import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/entities/breed.dart';

abstract class BreedRemoteDataSource {
  Future<List<String>?> getAllBreeds();
  Future<List<String>?> getBreedImagesFromApi(String breedName);

}

const BASE_URL = "dog.ceo";
const ALL_BREED_ENDPOINT = "/api/breeds/list/all";

class BreedRemoteDataSourceImpl implements BreedRemoteDataSource {
  final _getAllBreedUrl =
      Uri.https(BASE_URL, ALL_BREED_ENDPOINT, {'q': '{https}'});

  @override
  Future<bool> addToFav(Breed breed) async {
    return true;
  }

  _getBreedImagesUri(String breedName){

   return Uri.https(BASE_URL, "/api/breed/$breedName/images", {'q': '{https}'});
  }
  @override
  Future<List<String>?> getAllBreeds() async {


    var response = await http.get(_getAllBreedUrl);
    List<String>? list = [];
    if (response?.statusCode == 200) {
      var jsonResponse =
          jsonDecode(response!.body)["message"] as Map<String, dynamic>;

      if (jsonResponse != null) {
        jsonResponse.forEach((key, value) {
       list.add(key);

          // list.add(Breed(breedCategory: key, listOfDogs: listOfDogs));
        });
        return list;
      }
    }
    return null;
  }

  @override
  Future<bool> removeFav(String breedID) async {
    return true;
  }

  @override
  Future<List<String>?> getBreedImagesFromApi(String breedName) async {
    var response = await http.get(_getBreedImagesUri(breedName));
    List<String>? list = [];
    if (response.statusCode == 200) {

      list=  List.from(jsonDecode(response.body)["message"]);

      if (list != null) {

        return list;
      }
    }
    return null;
  }
}
