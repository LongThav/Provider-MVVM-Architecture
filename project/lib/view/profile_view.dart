import 'package:flutter/material.dart';
import 'package:project/data/response/api_response.dart';
import 'package:project/data/response/status.dart';
import 'package:project/db_helper/cache_profile.dart';
import 'package:project/model/profile_model.dart';
import 'package:project/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final CacheProfile _cacheProfile = CacheProfile();
  ProfileNotifier profileNotifier = ProfileNotifier();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileNotifier>().fetchingProfileNotifier();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                _cacheProfile.deleteAll();
                context.read<ProfileNotifier>().logoutViewModel(context);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    ApiResponse apiResponse = context.watch<ProfileNotifier>().apiResponse;
    if(apiResponse.status == Status.loading){
      return const Center(child: CircularProgressIndicator(),);
    }else if(apiResponse.status == Status.error){
      return const Center(child: Text("Error"),);
    }else{
      return _buildProfile(apiResponse.data);
    }
  }

  Widget _buildProfile(ProfileModel profileModel){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${profileModel.user.username}"),
          Text("Name: ${profileModel.user.email}"),
        ],
      ),
    );
  }
}
