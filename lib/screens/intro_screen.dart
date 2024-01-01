import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:swifty_mobile/screens/dashboard.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "This is your introduction page.",
          image: Image.asset("assets/images/delivery.jpg"),
        ),
        // Add more pages as needed
      ],
      onDone: () {
        // Navigate to Dashboard when done
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Dashboard(),
          ),
        );
      },
      onSkip: () {
        // Navigate to Dashboard when skipped
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Dashboard(),
          ),
        );
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      done: const Text("Done"),
      showNextButton: false,
    );
  }
}
