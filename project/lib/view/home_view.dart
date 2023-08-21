import 'package:flutter/material.dart';
import 'package:project/data/response/api_response.dart';
import 'package:project/data/response/status.dart';
import 'package:project/model/random_user_model.dart';
import 'package:provider/provider.dart';

import '../view_model/profile_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileNotifier>().fetchingRandomUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    ApiResponse apiResponse = context.watch<ProfileNotifier>().randomUser;
    if (apiResponse.status == Status.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (apiResponse.status == Status.error) {
      return const Center(
        child: Text("Error"),
      );
    } else {
      return _buildItem(apiResponse.data);
    }
  }

  Widget _buildItem(RandomInfoModel random) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProfileNotifier>().fetchingRandomUser();
      },
      child: ListView.builder(
          itemCount: random.results.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text("Id: $index"),
              title: Text(
                  "Name: ${"${random.results[index].name.first} ${random.results[index].name.last}"}"),
              subtitle: Container(
                width: 100,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(random.results[index].picture.medium),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          }),
    );
  }
}
