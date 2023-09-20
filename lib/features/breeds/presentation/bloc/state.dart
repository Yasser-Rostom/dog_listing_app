import 'package:dog_listing_app/features/breeds/data/models/breed_image.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/breed.dart';

abstract class BreedState extends Equatable {
  @override
  List<Object> get props => [];
}

class BreedStateInitial extends BreedState {
  @override
  List<Object> get props => [];
}

class BreedStateLoading extends BreedState {
  final bool isFetchingBreedList;

  BreedStateLoading({this.isFetchingBreedList= true});

  @override
  List<Object> get props => [isFetchingBreedList];
}

class BreedStateSuccess extends BreedState {
  final List<String>? breedList ;
  final List<String>? imageList ;
  final bool isFetchingBreedList;


  BreedStateSuccess(this.breedList, this.imageList, this.isFetchingBreedList);

  @override
  List<Object> get props => [breedList ??[],imageList??[],isFetchingBreedList];
}
class BreedStateFailure extends BreedState {
  final bool isFetchingBreedList;

  BreedStateFailure({this.isFetchingBreedList= true});
  @override
  List<Object> get props => [isFetchingBreedList];
}