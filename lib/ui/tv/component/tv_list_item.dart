import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../constants/constants.dart';
import '../../../model/tv_model.dart';
import '../tv_details.dart';

class TvListItem extends StatelessWidget {
  final TvModel tvModel;
  const TvListItem({super.key, required this.tvModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TvDetails(tvModel: tvModel)),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 140,
                width: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: kmovieImageURL + tvModel.posterPath.toString(),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              tvModel.originalName.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: (tvModel.voteAverage ?? 0) / 2,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    tvModel.voteAverage?.toStringAsFixed(1) ?? "0.0",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
