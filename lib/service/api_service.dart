import 'dart:convert';
import 'package:http/http.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/model/tv_model.dart';
import '../constants/constants.dart';
import '../model/cast_model.dart';
import '../model/video_model.dart';

enum MovieType { popular, topRated, upcoming, nowPlaying, latest, similar }

enum TvType { airingToday, onTheAir, popular, topRated, latest, similar }

enum ProgramType { tv, movie }

class ApiService {
  // ******-Movies-*****
  Future<List<MovieModel>> getMovieData(
    MovieType type, {
    int movieId = 0,
  }) async {
    String url = "";

    if (type == MovieType.popular) {
      url = kmovieDbURL + kpopular;
    } else if (type == MovieType.topRated) {
      url = kmovieDbURL + ktopRated;
    } else if (type == MovieType.upcoming) {
      url = kmovieDbURL + kupcoming;
    } else if (type == MovieType.nowPlaying) {
      url = kmovieDbURL + knowPlaying;
    } else if (type == MovieType.latest) {
      url = kmovieDbURL + knowlatest;
    } else if (type == MovieType.similar) {
      url = kmovieDbURL + movieId.toString() + ksimilar;
    }

    try {
      Response response = await get(
        Uri.parse(
          "$url?api_key=61500211a1ce1420c9086fb66b3b673a&language=en-US",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> body = data['results'];
        List<MovieModel> movielist = body
            .map((item) => MovieModel.fromJson(item))
            .toList();
        return movielist;
      } else {
        throw ("No Movie Found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // *****-Tv-*****
  Future<List<TvModel>> getTvData(TvType type, {int tvId = 0}) async {
    String url = "";

    if (type == TvType.popular) {
      url = ktvDbURL + kpopular;
    } else if (type == TvType.topRated) {
      url = ktvDbURL + ktopRated;
    } else if (type == TvType.airingToday) {
      url = ktvDbURL + kairingToday;
    } else if (type == TvType.onTheAir) {
      url = ktvDbURL + konTheAir;
    } else if (type == TvType.latest) {
      url = ktvDbURL + knowlatest;
    } else if (type == TvType.similar) {
      url = ktvDbURL + tvId.toString() + ksimilar;
    }

    try {
      Response response = await get(
        Uri.parse(
          "$url?api_key=61500211a1ce1420c9086fb66b3b673a&language=en-US",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> body = data['results'];
        List<TvModel> tvprogramlist = body
            .map((item) => TvModel.fromJson(item))
            .toList();
        return tvprogramlist;
      } else {
        throw ("No Tv Found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //*****-Movies & Tv Videos-*****
  Future<List<VideoModel>> getVideos(int id, ProgramType type) async {
    String url = "";

    if (type == ProgramType.movie) {
      url = kmovieDbURL + id.toString() + kvideos;
    } else if (type == ProgramType.tv) {
      url = ktvDbURL + id.toString() + kvideos;
    }

    try {
      Response response = await get(
        Uri.parse(
          "$url?api_key=61500211a1ce1420c9086fb66b3b673a&language=en-US",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> body = data['results'];
        List<VideoModel> videolist = body
            .map((item) => VideoModel.fromJson(item))
            .toList();
        return videolist;
      } else {
        throw ("No Video Found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //*****-cast-*****
  Future<List<CastModel>> getCastList(int id, ProgramType type) async {
    String url = "";

    if (type == ProgramType.movie) {
      url = kmovieDbURL + id.toString() + kcredits;
    } else if (type == ProgramType.tv) {
      url = ktvDbURL + id.toString() + kcredits;
    }

    try {
      Response response = await get(
        Uri.parse(
          "$url?api_key=61500211a1ce1420c9086fb66b3b673a&language=en-US",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> body = data['cast'];
        List<CastModel> castlist = body
            .map((item) => CastModel.fromJson(item))
            .toList();
        return castlist;
      } else {
        throw ("No Cast Found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<dynamic>> search(String query) async {
    try {
      Response response = await get(
        Uri.parse("$ksearchURL?api_key=$kapiKey&language=en-US&query=$query"),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> body = data['results'];
        List<dynamic> searchResults = [];
        for (var item in body) {
          if (item['media_type'] == 'movie') {
            searchResults.add(MovieModel.fromJson(item));
          } else if (item['media_type'] == 'tv') {
            searchResults.add(TvModel.fromJson(item));
          }
        }
        return searchResults;
      } else {
        throw ("No Results Found");
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
