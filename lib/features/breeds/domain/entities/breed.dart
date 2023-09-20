import 'package:equatable/equatable.dart';

class Breed extends Equatable{
  final String breedCategory;
  final List<String>? listOfDogs;

  const Breed({required this.breedCategory, required this.listOfDogs});


  @override
  List<Object?> get props => [listOfDogs,breedCategory];



}
