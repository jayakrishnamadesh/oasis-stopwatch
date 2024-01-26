import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Swatch(),
    );
  }
}

class Swatch extends StatefulWidget {
  const Swatch({Key? key}) : super(key: key);

  @override
  State<Swatch> createState() => _SwatchState();
}

class _SwatchState extends State<Swatch> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text('StopWatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value!, hours: _isHours);

                return Text(
                  displayTime,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  startButton(),
                  const SizedBox(
                    width: 10,
                  ),
                  stopButton(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            resetButton(),
          ],
        ),
      ),
    );
  }

  ElevatedButton startButton() {
    return ElevatedButton(
      onPressed: () {
        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      },
      child: const Text('Start'),
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  ElevatedButton stopButton() {
    return ElevatedButton(
      onPressed: () {
        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      },
      child: const Text('Stop'),
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  ElevatedButton resetButton() {
    return ElevatedButton(
      onPressed: () {
        _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      },
      child: const Text('Reset'),
      style: ElevatedButton.styleFrom(
          primary: Colors.red,
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}