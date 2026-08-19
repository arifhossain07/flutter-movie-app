import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../model/cast_model.dart';

class CastListItem extends StatelessWidget {
  final CastModel castModel;
  const CastListItem({super.key, required this.castModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 120,
      child: Column(
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            width: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/image/Image-not-found.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            imageUrl: kmovieImageURL + castModel.profilePath.toString(),
          ),

          SizedBox(height: 5),
          Text(
            castModel.name.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.white),
          ),

          SizedBox(height: 5),
          Text(
            castModel.knownForDepartment.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
