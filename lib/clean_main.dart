// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterView(),
    );
  }
}

class CounterEntity {
  final int count;

  CounterEntity({required this.count});
}

abstract class CounterRepository {
  Future<CounterEntity> getCount();
  Future<void> saveCount(CounterEntity counter);
}

class CounterUseCase {
  final CounterRepository repository;

  CounterUseCase({required this.repository});

  Future<CounterEntity> getCount() async {
    return await repository.getCount();
  }

  Future<void> incrementCount() async {
    CounterEntity counter = await repository.getCount();
    counter = CounterEntity(count: counter.count + 1);
    await repository.saveCount(counter);
  }
}

class CounterPresenter {
  void presentCount(CounterEntity counter) {
    print('Count: ${counter.count}');
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  CounterViewState createState() => CounterViewState();
}

class CounterViewState extends State<CounterView> {
  final CounterPresenter _presenter = CounterPresenter();
  final CounterUseCase _useCase = CounterUseCase(repository: _repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: FutureBuilder<CounterEntity>(
          future: _useCase.getCount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _presenter.presentCount(snapshot.data!);
              return Text(
                'Count: ${snapshot.data!.count}',
                style: const TextStyle(fontSize: 24),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _useCase.incrementCount();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterRepositoryImpl implements CounterRepository {
  @override
  Future<CounterEntity> getCount() {
    return Future.value(CounterEntity(count: 5));
  }

  @override
  Future<void> saveCount(CounterEntity counter) async {
    print('saveCount');
  }
}

final CounterRepository _repository = CounterRepositoryImpl();
