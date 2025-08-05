import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'provider_counter.dart';
import 'bloc_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter Types',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(
      BuildContext context,
      Widget screen, {
        bool useProvider = false,
        bool useBloc = false,
      }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          if (useProvider) {
            return ChangeNotifierProvider<ProviderCounter>(
              create: (_) => ProviderCounter(),
              child: screen,
            );
          } else if (useBloc) {
            return BlocProvider<CounterCubit>(
              create: (_) => CounterCubit(),
              child: screen,
            );
          } else {
            return screen;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  context,
                  const ProviderCounterScreen(),
                  useProvider: true,
                );
              },
              child: const Text('Provider Counter'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  context,
                  const BlocCounterScreen(),
                  useBloc: true,
                );
              },
              child: const Text('BLoC Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
