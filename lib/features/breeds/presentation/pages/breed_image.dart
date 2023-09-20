import 'package:dog_listing_app/core/local_storage.dart';
import 'package:dog_listing_app/features/breeds/data/models/breed_image.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/bloc.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/event.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/state.dart';
import 'package:dog_listing_app/features/breeds/presentation/widgets/breed_image/breed_image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedImageListing extends StatefulWidget {
  final String breedName;
  final bool isFetchingFromApi;
  const BreedImageListing({super.key, required this.breedName, required this.isFetchingFromApi});

  @override
  State<BreedImageListing> createState() => _BreedImageListingState();
}

class _BreedImageListingState extends State<BreedImageListing> {
  bool isFav= false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<BreedBloc>().add(BreedEventFetched(
          isFetchingFromAPI: widget.isFetchingFromApi,
        ));
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {
              context.read<BreedBloc>().add(BreedEventFetched(
                    isFetchingFromAPI: widget.isFetchingFromApi,
                  )),
              Navigator.pop(context)
            },
          ),
          title: const Text("Breed's Images"),
          centerTitle: true,
        ),
        body: BlocBuilder<BreedBloc, BreedState>(builder: (context, state) {
          if (state is BreedStateLoading && mounted) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          }
          if (state is BreedStateSuccess &&
              !state.isFetchingBreedList &&
              mounted) {
            return Column(mainAxisSize:MainAxisSize.min,children: [
              Container(height: 30,),

              Text(widget.breedName, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Container(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(isFav? "Click the sign to remove from the favorite list" :"Press the sign to add to your favorite list "),
                  IconButton(onPressed: ()=>{
                    handleFavBtnClicked(state.imageList),
                  }, icon:  Icon(isFav? Icons.remove_circle : Icons.add,color:isFav? Colors.red: Colors.blue,)),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.7,
                child: BreedImageList(
                  list: state.imageList ?? [],
                ),
              ),
            ]);
          }
          if (state is BreedStateFailure) {
            return Center(
                child: Column(
              children: [
                Container(
                  height: 50,
                ),
                const Text("Failed to Fetch"),
                TextButton(
                    onPressed: () => {
                          context.read<BreedBloc>().add(
                              BreedImageEventFetched(breedName: widget.breedName, isFetchingFromApi: widget.isFetchingFromApi))
                        },
                    child: const Text("RETRY"))
              ],
            ));
          }
          return Container();
        }),
      ),
    );
  }

  @override
  void initState() {
    //fetching breed image list for a specific breed name
    context
        .read<BreedBloc>()
        .add(BreedImageEventFetched(breedName: widget.breedName, isFetchingFromApi: widget.isFetchingFromApi));
    super.initState();
    checkIfFavorite();
  }

  checkIfFavorite() async{

    final count = await DatabaseHelper().queryRowCount(widget.breedName);
    setState(() {
      isFav = count> 0? true: false;
    });
  }
  handleFavBtnClicked(List<String>? imageList) async {
    int count = 0;
    if(isFav){
       count = await DatabaseHelper().delete(widget.breedName);
    }else{
      count = await DatabaseHelper().addFav(BreedWithImagesLocalModel(breedName: widget.breedName, imageList: imageList??[]));

    }
    if(count>0){
      setState(() {
        isFav=!isFav;
      });
    }
  }
}
