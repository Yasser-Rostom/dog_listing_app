import 'package:dog_listing_app/core/local_storage.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/bloc.dart';
import 'package:dog_listing_app/features/breeds/presentation/pages/home.dart';
import 'package:dog_listing_app/features/breeds/presentation/widgets/breed_list/breed_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return BreedBloc();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home:  const HomePage(),
      ),
    );
  }
}

