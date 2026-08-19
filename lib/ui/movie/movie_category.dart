import 'package:flutter/material.dart';
import 'package:movies_app/service/api_service.dart';
import '../../model/movie_model.dart';
import 'component/movie_list_item.dart';

class MovieCategory extends StatefulWidget {
  final MovieType movieType;
  final int movieId;
  const MovieCategory({super.key, required this.movieType, this.movieId = 0});

  @override
  State<MovieCategory> createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> movielist = snapshot.data ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return MovieListItem(movieModel: movielist[index]);
            },
            itemCount: movielist.length,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      future: apiService.getMovieData(
        widget.movieType,
        movieId: widget.movieId,
      ),
    );
  }
}
