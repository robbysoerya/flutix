import 'package:firebase_core/firebase_core.dart';
import 'package:flutix/bloc/bloc.dart';
import 'package:flutix/services/services.dart';
import 'package:flutix/ui/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
  ));

    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => PageBloc(),
            ),
            BlocProvider(
              create: (_) => UserBloc(),
            ),
            BlocProvider(
              create: (_) => ThemeBloc(),
            ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (_, themeState) {
              return MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: MainWrapper());
            },
          )),
    );
  }
}
