import 'package:flutter/material.dart';
import 'package:mvvm/data/response/Status.dart';
import 'package:mvvm/utils/routes/route_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/user_view_modal.dart';

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
    final userViewModel = Provider.of<UserViewModal>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  userViewModel.remove();
                  Navigator.pushNamed(context, RouteNames.login);
                },
                child: const Text("Logout",
                    style: TextStyle(color: Colors.white))),
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
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.movieList.message.toString()));
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
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(value.movieList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value.movieList.data!.movies![index].year
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(value
                                    .movieList.data!.movies![index].ratings!)
                                .toStringAsFixed(1)),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            default:
              return const Text("No DATA");
          }
          return Container();
        }),
      ),
    );
  }
}
