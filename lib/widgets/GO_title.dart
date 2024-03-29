import 'package:flutter/material.dart';

class GradientTitle extends StatelessWidget {
  const GradientTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // double fontSize = Theme.of(context).textTheme.titleMedium!.fontSize ?? 20;
    // double letterWidth = fontSize;
    // print(fontSize);

    final Shader linearGradient_G = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, 0.4826, 1],
      colors: <Color>[
        Color(0xFFE9ADB7),
        Color(0xFFDBCCE0),
        Color(0xFFB2BAE0),
      ],
    ).createShader(
      Rect.fromLTWH(0, 0, 25, 25),
    );

    final Shader linearGradient_oo = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3704, 0.564, 0.7593],
      colors: <Color>[
        Color(0xFFE7CDDA),
        Color(0xFFD3CDE5),
        Color(0xFFAFB8DE),
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 125, 125),
    );

    final Shader linearGradient_d = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.4373, 0.4866, 0.5513, 0.6654],
      colors: [
        Color(0xFFFAE9E8), // #FAE9E8
        Color(0xFFFFFFFF), // #FFF
        Color(0xFFE6DCEC), // #E6DCEC
        Color(0xFFAAADD5), // #AAADD5
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 50, 50),
    );

    final Shader linearGradient_O = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3148, 0.7407],
      colors: <Color>[
        Color(0xFFFFFFFF), // #FFF
        Color(0xFFBDAFE3), // #BDAFE3
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 120, 120),
    );

    final Shader linearGradient_m = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3333, 0.5113, 0.7407],
      colors: <Color>[
        Color(0xFFFFFFFF), // #FFF
        Color(0xFFCBB4D7), // #CBB4D7
        Color(0xFF9B8DBB), // #9B8DBB
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 125, 125),
    );

    final Shader linearGradient_e = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3333, 0.518, 0.7037],
      colors: <Color>[
        Color(0xFFFFFFFF), // #FFF
        Color(0xFFC3A9CF), // #C3A9CF
        Color(0xFF9786B4), // #9786B4
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 125, 125),
    );

    final Shader linearGradient_n = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3148, 0.5233, 0.7407],
      colors: <Color>[
        Color(0xFFFFFFFF), // #FFF
        Color(0xFFD1B8D8), // #D1B8D8
        Color(0xFFBDAFE3), // #BDAFE3
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 125, 125),
    );

    final Shader linearGradient_s = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3286, 0.5113, 0.7018],
      colors: <Color>[
        Color(0xFFFFFFFF), // #FFF
        Color(0xFFD1B8D8), // #D1B8D8
        Color(0xFFBDAFE3), // #BDAFE3
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 125, 125),
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'G',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_G,
                ),
          ),
          TextSpan(
            text: 'o',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_oo,
                ),
          ),
          TextSpan(
            text: 'o',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_oo,
                ),
          ),
          TextSpan(
            text: 'd',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_d,
                ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'O',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_O,
                ),
          ),
          TextSpan(
            text: 'm',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(foreground: Paint()..shader = linearGradient_m),
          ),
          TextSpan(
            text: 'e',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_e,
                ),
          ),
          TextSpan(
              text: 'n',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(foreground: Paint()..shader = linearGradient_n)),
          TextSpan(
            text: 's',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  foreground: Paint()..shader = linearGradient_s,
                ),
          ),
        ],
      ),
    );
  }
}
