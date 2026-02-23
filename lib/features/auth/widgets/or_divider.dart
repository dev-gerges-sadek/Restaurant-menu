import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Divider(thickness: 1, color: Color(0xff616161)),
            ),
            Text(
              " Or continue with ",
              style: TextStyle(color: Color(0xff616161)),
            ),
            SizedBox(
              width: 100,
              child: Divider(thickness: 1, color: Color(0xff616161)),
            ),
          ],
        ),
        Row(
          spacing: 18,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google.png"),
            Image.asset("assets/images/apple.png"),
            Image.asset("assets/images/facebook.png"),
          ],
        ),
      ],
    );
  }
}
