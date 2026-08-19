import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/model/tv_model.dart';
import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/ui/movie/movie_home.dart';
import 'package:movies_app/ui/tv/tv_home.dart';
import 'package:movies_app/ui/movie/component/movie_list_item.dart';
import 'package:movies_app/ui/tv/component/tv_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Widget getView() {
    if (_selectedIndex == 0) {
      return MovieHome();
    } else {
      return TvHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text(
          "ShowTime",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV"),
        ],
      ),
    );
  }
}


class MovieSearchDelegate extends SearchDelegate {
  ApiService apiService = ApiService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchLogic();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchLogic();
  }

  Widget _searchLogic() {
    if (query.isEmpty) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text("Search Movies or TV Shows", style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: FutureBuilder(
        future: apiService.search(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> results = snapshot.data ?? [];
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                var item = results[index];
                if (item is MovieModel) {
                  return MovieListItem(movieModel: item);
                } else if (item is TvModel) {
                  return TvListItem(tvModel: item);
                }
                return const SizedBox();
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
