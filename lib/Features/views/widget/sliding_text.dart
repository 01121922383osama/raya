import 'package:flutter/cupertino.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child: const Text(
              'Raya Institute',
              style: TextStyle(
                fontSize: 35,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}
