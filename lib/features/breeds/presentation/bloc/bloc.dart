import 'package:dog_listing_app/core/local_storage.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/event.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/breed_api_datasource.dart';
import '../../data/datasources/breed_local_datasource.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  BreedBloc() : super(BreedStateInitial()) {
    on<BreedEventFetched>(_fetchBreedResults);
    on<BreedImageEventFetched>(_fetchBreedImages);
  }

  List<String>? listOfBreed;

  List<String>? listOfBreedImages;

  Future<void> _fetchBreedResults(BreedEventFetched event, Emitter emit) async {
    emit(BreedStateLoading());
    try {
      if (event.isFetchingFromAPI) {
        listOfBreed = await BreedRemoteDataSourceImpl().getAllBreeds();
      } else {
        listOfBreed = await BreadLocalDataSourceImpl().getAllFavBreedNames();
      }
      if (listOfBreed != null) {
        emit(BreedStateSuccess(listOfBreed, null, true));
      } else {
        emit(BreedStateFailure());
      }
    } catch (e) {
      debugPrint("myError: $e");
      emit(BreedStateFailure());
    }
  }

  Future<void> _fetchBreedImages(
      BreedImageEventFetched event, Emitter emit) async {
    emit(BreedStateLoading(isFetchingBreedList: false));
    try {
      if(event.isFetchingFromApi){
        listOfBreedImages = await BreedRemoteDataSourceImpl()
            .getBreedImagesFromApi(event.breedName);
      }
     else{
        listOfBreedImages = await DatabaseHelper().fetchFavBreedImages(event.breedName);
      }
      if (listOfBreedImages != null) {
        emit(BreedStateSuccess(null, listOfBreedImages, false,));
      } else {
        emit(BreedStateFailure(isFetchingBreedList: false));
      }
    } catch (e) {
      debugPrint("myError: $e");
      emit(BreedStateFailure(isFetchingBreedList: false));
    }
  }
}
