import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/status.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view_model/user_list_view_model.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserListViewModel userListViewModel = UserListViewModel();

  @override
  void initState() {
    super.initState();
    userListViewModel.fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          actions: [
            InkWell(
              onTap: () {
                userViewModel.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Center(child: Text("Logout")),
            ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        body: ChangeNotifierProvider<UserListViewModel>(
          create: (BuildContext context) => userListViewModel,
          child: Consumer<UserListViewModel>(builder: (context, value, _) {
            switch (value.apiResponse.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.apiResponse.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.apiResponse.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text(
                            value.apiResponse.data!.data![index]!.firstName!),
                        subtitle: Text(
                            value.apiResponse.data!.data![index]!.lastName!),
                        leading: Image.network(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          value.apiResponse.data!.data![index]!.avatar!,
                          errorBuilder: (context, error, stack) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                            trailing: Text(value.apiResponse.data!.data![index]!.id!.toString()),
                      ));
                    });
              default:
                return Container();
            }
            return Container();
          }),
        ));
  }
}

