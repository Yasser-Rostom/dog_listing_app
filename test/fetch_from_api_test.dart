import 'package:dog_listing_app/features/breeds/data/datasources/breed_api_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

//this testing could be enhanced by using mocking
void main(){
  group("checking fetching breed names and images", () {
    test("Fetch All breeds from api", () async {
      bool done = false;
      var fetch = (await BreedRemoteDataSourceImpl().getAllBreeds());
      if(fetch != null){
        if(fetch.isNotEmpty) {
          done = true;
        }
      }
      expect(done, true);
    });
    test("Fetch images of the African breed from api", () async {
      bool done = false;
      var fetch = (await BreedRemoteDataSourceImpl().getBreedImagesFromApi("african"));
      if(fetch != null){
        if(fetch.isNotEmpty) {
          done = true;
        }
      }
      expect(done, true);
    });
    
    
  });
 
}