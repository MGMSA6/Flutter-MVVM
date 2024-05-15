import 'package:flutter/material.dart';
import 'package:mvvm/data/response/Status.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {},
                child: Text("Logout", style: TextStyle(color: Colors.white))),
          )
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, _) {
          switch (value.movieList.status) {
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.movieList.message.toString());
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: value.movieList.data!.movies!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(

                        leading: Image.network(
                          value.movieList.data!.movies![index].posterurl
                              .toString(),
                          errorBuilder: (context, error, stack) {
                            return Icon(Icons.error);
                          },
                        ),
                        title: Text(value.movieList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value.movieList.data!.movies![index].year
                            .toString()),
                      ),
                    );
                  });
            default:
              return Text("No DATA");
          }
          return Container();
        }),
      ),
    );
  }
}
