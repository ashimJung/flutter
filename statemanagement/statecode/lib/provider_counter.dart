import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderCounter with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }
}

class ProviderCounterScreen extends StatelessWidget {
  const ProviderCounterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<ProviderCounter>(context, listen: true);


    return Scaffold(
      appBar: AppBar(title: const Text('Provider Counter')),
      body: Center(
        child: Text('${counter.count}', style: const TextStyle(fontSize: 40)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: counter.decrement,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: counter.increment,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
