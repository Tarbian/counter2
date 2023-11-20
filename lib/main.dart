import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/page1',
      routes: {
        '/page1': (context) => const PageOne(),
        '/page2': (context) => const PageTwo(),
        '/page3': (context) => const PageThree(),
      },
    );
  }
}

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  _PageOne createState() => _PageOne();
}

class _PageOne extends State<PageOne> {
  late int number;

  void incrementNumber() {
    setState(() {
      number++;
    });
  }

  @override
  void initState() {
    number = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The number is : $number',
              style: const TextStyle(fontSize: 24.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    incrementNumber();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/page2', arguments: number);
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  _PageTwo createState() => _PageTwo();
}

class _PageTwo extends State<PageTwo> {
  late int number;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    number = ModalRoute.of(context)!.settings.arguments as int;
  }

  @override
  Widget build(BuildContext context) {
    number = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The number is : $number',
              style: const TextStyle(fontSize: 24.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      number--;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/page3', arguments: number);
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final int number = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The number is : $number',
              style: const TextStyle(fontSize: 24.0),
            ),
            ElevatedButton(
              onPressed: () {
                // Очищення стеку та перехід на '/page1'
                Navigator.pushNamedAndRemoveUntil(
                    context, '/page1', (route) => false,
                    arguments: 0);
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
