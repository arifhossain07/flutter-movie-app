import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_model.dart';

import '../../../constants/constants.dart';
import '../movie_details.dart';

class MovieCarousel extends StatefulWidget {
  final List<MovieModel> movielist;
  const MovieCarousel({super.key, required this.movielist});

  @override
  State<MovieCarousel> createState() => _MovieComponentState();
}

class _MovieComponentState extends State<MovieCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.movielist.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieDetails(movieModel: widget.movielist[itemIndex]),
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
                  widget.movielist[itemIndex].posterPath.toString(),
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
