import 'package:flutter/material.dart';

// Model
class CounterModel {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
  }
}

// View
class CounterView extends StatefulWidget {
  final CounterModel model;

  const CounterView({super.key, required this.model});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Counter Value:",
            ),
            Text(
              "${widget.model.counter}",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Controller로 이벤트 전달
            Controller.incrementCounter(widget.model);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Controller
class Controller {
  static void incrementCounter(CounterModel model) {
    model.incrementCounter();
  }
}

// 실행 코드
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CounterModel _model = CounterModel();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterView(
        model: _model,
      ),
    );
  }
}