import 'package:flutter/cupertino.dart';

import 'breed_tile.dart';

class BreeedList extends StatelessWidget {
  List<String>? breedList;
  bool isFetchingFromApi;
  BreeedList({super.key, this.breedList, required this.isFetchingFromApi});

  @override
  Widget build(BuildContext context) {
    return breedList != null && breedList!.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5 / 2,
              crossAxisCount: (MediaQuery.of(context).size.width / 300).round(),
            ),
            itemCount: breedList?.length,

            itemBuilder: (BuildContext context, int index) {
              return BreedTile(
                isFetchingFromApi: isFetchingFromApi,
                breedName:
                     breedList![index]

              );
            })
        : const Center(
            child: Text("No breed to display"),
          );
  }
}
