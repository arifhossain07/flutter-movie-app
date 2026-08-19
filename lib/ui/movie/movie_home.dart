import 'package:flutter/material.dart';
import '../../model/movie_model.dart';
import '../../service/api_service.dart';
import 'component/movie_carousel.dart';
import 'movie_category.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({super.key});

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MovieModel> moviedata = snapshot.data ?? [];
              return MovieCarousel(movielist: moviedata);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: apiService.getMovieData(MovieType.popular),
        ),

        SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Popular Movies",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),

                SizedBox(
                  height: 200,
                  child: MovieCategory(movieType: MovieType.popular),
                ),
                SizedBox(height: 8),

                Text(
                  "Top Rated Movies",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: MovieCategory(movieType: MovieType.topRated),
                ),
                SizedBox(height: 8),

                Text(
                  "Upcoming Movies",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: MovieCategory(movieType: MovieType.upcoming),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
