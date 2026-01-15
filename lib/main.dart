import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/core/theme/app_theme.dart';
import 'package:algo_botix_assignment/screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Injecting ProductBloc and immediately triggering the 'Load' event
        // to fetch initial data from SQLite as soon as the app starts.
        BlocProvider(create: (context) => ProductBloc()..add(LoadProducts())),
      ],
      child: MaterialApp(
        title: 'AlgoBotix Inventory',
        debugShowCheckedModeBanner: false,
        // Applying the centralized theme defined in core/theme
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
