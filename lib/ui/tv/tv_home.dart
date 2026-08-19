import 'package:flutter/material.dart';
import 'package:movies_app/model/tv_model.dart';
import 'package:movies_app/ui/tv/tv_category.dart';
import '../../service/api_service.dart';
import 'component/tv_carousel.dart';

class TvHome extends StatefulWidget {
  const TvHome({super.key});

  @override
  State<TvHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<TvHome> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<TvModel> tvdata = snapshot.data ?? [];
              return TvCarousel(tvlist: tvdata);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: apiService.getTvData(TvType.airingToday),
        ),
        SizedBox(height: 8),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Popular Tv",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),

                SizedBox(
                  height: 200,
                  child: TvCategory(tvType: TvType.popular),
                ),
                SizedBox(height: 8),

                Text(
                  "Top Rated Tv",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: TvCategory(tvType: TvType.topRated),
                ),
                SizedBox(height: 8),

                Text(
                  "On The Air Tv",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: TvCategory(tvType: TvType.onTheAir),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}