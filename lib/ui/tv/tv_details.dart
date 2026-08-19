import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/ui/tv/tv_category.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/cast_page.dart';
import '../../constants/constants.dart';
import '../../model/tv_model.dart';
import '../../model/video_model.dart';
import '../../service/api_service.dart';

class TvDetails extends StatelessWidget {
  final TvModel tvModel;
  const TvDetails({super.key, required this.tvModel});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(tvModel.name.toString()), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,

                //*****-Poster,Youtube Link-*****
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl:
                          kmovieImageURL + tvModel.backdropPath.toString(),
                    ),
                  ),
                  FutureBuilder(
                    future: apiService.getVideos(
                      tvModel.id ?? 0,
                      ProgramType.movie,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];
                        if (videos.isNotEmpty) {
                          return CircleAvatar(
                            child: IconButton(
                              onPressed: () async {
                                if (!await launchUrl(
                                  Uri.parse(
                                    'https://www.youtube.com/watch?v=${videos[0].key}',
                                  ),
                                )) {
                                  throw Exception('Could not launch');
                                }
                              },
                              icon: Icon(Icons.play_arrow),
                            ),
                          );
                        }
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),

              //*****-Name-*****
              SizedBox(height: 5),
              Text(
                tvModel.name.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),

              //*****-Rating, Release Date-*****
              Row(
                children: [
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: tvModel.voteAverage ?? 0,
                        itemBuilder: (context, index) {
                          return Icon(Icons.star, color: Colors.amber);
                        },
                        itemCount: 5,
                        itemSize: 15,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 5),
                      Text(
                        tvModel.voteAverage == null
                            ? ""
                            : tvModel.voteAverage.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    "Release Date: ${tvModel.firstAirDate.toString()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              //*****-Cast-*****
              SizedBox(height: 5),
              Text(
                tvModel.overview.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text("Cast", style: TextStyle(color: Colors.white, fontSize: 20)),

              SizedBox(
                height: 200,
                child: CastPage(type: ProgramType.tv, id: tvModel.id ?? 0),
              ),

              //*****-Similar Tv Shows-*****
              SizedBox(height: 5),
              Text(
                "Similar Tv Shows",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: TvCategory(
                  tvType: TvType.similar,
                  tvId: tvModel.id ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
