import 'package:equatable/equatable.dart';

class FavBreed extends Equatable{
  final String breedName;

  const FavBreed({required this.breedName});


  @override
  List<Object?> get props => [breedName];



}