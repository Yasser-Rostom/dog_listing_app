import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  String? imageUrl;

  ImageTile({super.key,  this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 100, // Image radius
        backgroundImage: NetworkImage(imageUrl!),
      ),
    );
  }
}
