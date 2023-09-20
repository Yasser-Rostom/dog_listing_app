import 'package:flutter/cupertino.dart';

import 'image_tile.dart';

class BreedImageList extends StatelessWidget {
  List<String> list;
  BreedImageList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),

        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ImageTile(
            imageUrl: list[index].toString(),
          );
        }
    );
  }
}
