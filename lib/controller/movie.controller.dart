// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:favorite_movie/model/cast.detail.model.dart';
import 'package:favorite_movie/model/cast.model.dart';
import 'package:favorite_movie/model/get.list.cart.dart';
import 'package:favorite_movie/model/image.model.dart';
import 'package:favorite_movie/model/image.response.model.dart';
import 'package:favorite_movie/model/key.word.model.dart';
import 'package:favorite_movie/model/movie.details.model.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/model/person.response.dart';
import 'package:favorite_movie/model/search.image.model.dart';
import 'package:favorite_movie/model/search.model.dart';
import 'package:favorite_movie/model/search.moview.of.cast.model.dart';
import 'package:favorite_movie/model/videos.response.dart';

import '../model/movie.lists.model.dart';
import 'package:http/http.dart' as http;

class MovieController {
  final token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MDEwMjI1NmIzYWFkZGFlMDk0NDE4MDNhZTIyMzkzNyIsInN1YiI6IjY2MzZjM2FmYzM5MjY2MDEyNjZlZjczMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dxvcsgaRkMRw60wNsvchRxsvm0f6L1_bFCwbngS3PwI";
  final apiKey = '60102256b3aaddae09441803ae223937';

  Future<MovieListsModel?> getListTrendingDay({required int page}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse('https://api.themoviedb.org/3/trending/movie/day?language=en-US'), headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel = MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieListsModel?> getListTrendingWeek({required int page}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?language=en-US'), headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel = MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieListsModel?> getListNowPlaying({required int page}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=$page'), headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel = MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieListsModel?> getPopular({required int page}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?language=en-US&page=$page'), headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel = MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieListsModel?> getUpcoming({required int page}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=$page'), headers: headers);
      if (response.statusCode == 200) {
        MovieListsModel movieListsModel = MovieListsModel.fromJson(response.body);
        return movieListsModel;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<MovieDetailsModel?> getMovieDetails({required int idMovie}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse('https://api.themoviedb.org/3/movie/$idMovie?language=en-US'), headers: headers);
      if (response.statusCode == 200) {
        MovieDetailsModel movieModel = MovieDetailsModel.fromJson(response.body);
        return movieModel;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<KeywordModel>> getListKeyword({required int idMovie}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/$idMovie/keywords"), headers: headers);
      if (response.statusCode == 200) {
        var jsonDecode = json.decode(response.body);
        return List<KeywordModel>.from(jsonDecode["keywords"].map((x) => KeywordModel.fromMap(x)));
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<CastModel>> getListCast({required int idMovie}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/$idMovie/credits?language=en-US"), headers: headers);
      if (response.statusCode == 200) {
        GetListCast getListCast = GetListCast.fromJson(response.body);
        return getListCast.cast;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<Video>> getListVideo({required int idMovie}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/$idMovie/videos?language=en-US"), headers: headers);
      if (response.statusCode == 200) {
        VideosResponse videosResponse = VideosResponse.fromMap(json.decode(response.body) as Map<String, dynamic>);
        return videosResponse.results ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<SearchImageModel?> getImageMoview({required int idMovie}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/$idMovie/images"), headers: headers);
      if (response.statusCode == 200) {
        SearchImageModel videosResponse = SearchImageModel.fromMap(json.decode(response.body) as Map<String, dynamic>);
        return videosResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<PersonResponse?> getPersonResponse({required int idPersion}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/person/$idPersion?language=en-US"), headers: headers);
      if (response.statusCode == 200) {
        PersonResponse personResponse = PersonResponse.fromMap(json.decode(response.body) as Map<String, dynamic>);
        return personResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<SearchModel?> getDataSearch({required String findName, required int page}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse("Https://api.themoviedb.org/3/search/movie?query=$findName&include_adult=false&language=en-US&page=$page"),
          headers: headers);
      if (response.statusCode == 200) {
        SearchModel personResponse = SearchModel.fromJson(response.body);
        return personResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<CastDetailModel?> getCastDetail({required int castId}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/person/$castId?language=en-US'"), headers: headers);
      if (response.statusCode == 200) {
        CastDetailModel personResponse = CastDetailModel.fromJson(response.body);
        return personResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<ImageModel>> getImageCastDetail({required int castId}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/person/$castId/images"), headers: headers);
      if (response.statusCode == 200) {
        ImageResponseModel imageResponseModel = ImageResponseModel.fromJson(response.body);
        return imageResponseModel.profiles ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<MovieModel>> getMovieCastDetail({required int castId}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse("https://api.themoviedb.org/3/person/$castId/movie_credits?language=en-US"), headers: headers);
      if (response.statusCode == 200) {
        SearchMovieOfCastModel imageResponseModel = SearchMovieOfCastModel.fromJson(response.body);
        return imageResponseModel.cast ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
