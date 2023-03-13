import 'package:auth_app/blocs/app/app_bloc.dart';
import 'package:auth_app/config/routes.dart';
import 'package:auth_app/firebase_options.dart';
import 'package:auth_app/repositories/auth_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'auth-9ca42',
        options: DefaultFirebaseOptions.currentPlatform);
    final authRepository = AuthRepository();
    runApp(MyApp(authRepository: authRepository));
  }, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlowBuilder(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPage),
    );
  }
}

/*
class Plate extends StatefulWidget {
  late _PlateState myState;


  @override
  State<Plate> createState() {
    myState = new _PlateState();
    return myState;
  }
}

class _PlateState extends State<Plate> {
  late Color _color;

  Color get color=>_color;
  @override
  Widget build(BuildContext context) {
    return PlateChild();
  }
}

class PlateChild extends StatelessWidget {
  const PlateChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Plate plt=context.getElementForInheritedWidgetOfExactType() as Plate;
    final _PlateState state= plt.myState;
    return Container(
      color:  state == null ? Colors.green : state.color
    );
  }
}
*/
