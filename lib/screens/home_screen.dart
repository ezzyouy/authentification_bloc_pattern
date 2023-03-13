import 'package:auth_app/blocs/app/app_bloc.dart';
import 'package:auth_app/screens/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context.read<AppBloc>().add(AppLogoutRequest());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50,
            backgroundImage:
                user.photo != null ? NetworkImage(user.photo!) : null,
            child: user.photo == null ? const Icon(Icons.person, size: 80,) : null,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(user.email ?? '')
        ]),
      ),
    );
  }
}
