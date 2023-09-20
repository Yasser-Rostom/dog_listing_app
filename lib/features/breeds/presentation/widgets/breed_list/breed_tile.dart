import 'package:dog_listing_app/features/breeds/presentation/pages/breed_image.dart';
import 'package:flutter/material.dart';

class BreedTile extends StatelessWidget {
  String breedName;
  bool isFetchingFromApi;
  BreedTile({super.key, required this.breedName, required this.isFetchingFromApi});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BreedImageListing(
                isFetchingFromApi: isFetchingFromApi,
                    breedName: breedName,
                  )),
        )
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.fromLTRB(10, 5, 5, 10),
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 12),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(breedName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            const Text(">",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
