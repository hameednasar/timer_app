import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int countdownTime = 10; // Initial countdown time in seconds
  bool isRunning = false;

  // Function to calculate the color based on the remaining time
  Color getTimerColor(int time) {
    final double ratio = time / 10; // Calculate the ratio (0.0 to 1.0)
    return Color.lerp(
        Colors.red, Colors.green, ratio)!; // Interpolate between red and green
  }

  // Function to start the timer
  void startTimer() async {
    if (isRunning) return; // Prevent multiple timers
    setState(() {
      isRunning = true;
    });

    for (int i = countdownTime; i >= 0; i--) {
      setState(() {
        countdownTime = i;
      });
      await Future.delayed(Duration(seconds: 1));
    }

    setState(() {
      isRunning = false; // Timer has completed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Countdown Timer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$countdownTime',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: getTimerColor(countdownTime), // Dynamically set color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startTimer,
              child: Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
