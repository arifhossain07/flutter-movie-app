import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/tv_model.dart';
import '../../../constants/constants.dart';
import '../tv_details.dart';

class TvCarousel extends StatefulWidget {
  final List<TvModel> tvlist;
  const TvCarousel({super.key, required this.tvlist});

  @override
  State<TvCarousel> createState() => _TvCarouselState();
}

class _TvCarouselState extends State<TvCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.tvlist.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TvDetails(tvModel: widget.tvlist[itemIndex]),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl:
                  kmovieImageURL +
                  widget.tvlist[itemIndex].posterPath.toString(),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
