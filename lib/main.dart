import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/repository/routes/routes.dart';
import 'package:saler/repository/sqlite.dart';
import 'package:saler/screens/table/table.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SqliteDBRepository>(
            create: (_) => SqliteDBRepository())
      ],
      child: MaterialApp(
          title: 'Task',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: "/",
          onGenerateRoute: generateRoute),
    );
  }
}
