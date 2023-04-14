import 'package:flutter/material.dart';

// 실행 코드
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
      home: const CounterExample(),
    );
  }
}

class CounterExample extends StatefulWidget {
  const CounterExample({
    Key? key,
  }) : super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<CounterExample> implements Counter {
  final BasicCounterPresenter presenter = BasicCounterPresenter();
  CounterModel _viewModel = CounterModel(0);
  @override
  void initState() {
    super.initState();
    presenter.counterView = this;
  }

  @override
  void refreshCounter(CounterModel viewModel) {
    setState(() {
      _viewModel = viewModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mvp demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                "Click buttons to add and substract.",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    presenter.decrementCounter();
                  },
                  child: const Icon(Icons.remove),
                ),
                Text(
                  "${_viewModel.counter}",
                ),
                FloatingActionButton(
                  onPressed: () {
                    presenter.incrementCounter();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainModel {
  MainModel({this.counter = 0});

  int counter;
}

class BasicCounterPresenter {
  final CounterModel _counterViewModel = CounterModel(0);
  Counter _counterView = Counter();
  void incrementCounter() {
    _counterViewModel.counter++;
    _counterView.refreshCounter(_counterViewModel);
  }

  void decrementCounter() {
    _counterViewModel.counter--;
    _counterView.refreshCounter(_counterViewModel);
  }

  set counterView(Counter value) {
    _counterView = value;
    _counterView.refreshCounter(_counterViewModel);
  }
}

class Counter {
  void refreshCounter(CounterModel viewModel) {}
}

class CounterModel {
  int counter;
  CounterModel(this.counter);
}