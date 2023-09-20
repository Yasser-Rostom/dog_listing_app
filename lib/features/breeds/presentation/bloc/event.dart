import 'package:equatable/equatable.dart';

import '../../domain/entities/breed.dart';

abstract class BreedEvent extends Equatable {}

 class BreedEventFetched extends BreedEvent {
  final bool isFetchingFromAPI ;

  BreedEventFetched({ this.isFetchingFromAPI= true});

   @override
  List<Object?> get props => [isFetchingFromAPI];
}

class BreedImageEventFetched extends BreedEvent {
 String breedName;
 bool isFetchingFromApi;
 BreedImageEventFetched({required this.breedName,  this.isFetchingFromApi=true});

 @override
 List<Object?> get props => [breedName,isFetchingFromApi];
}