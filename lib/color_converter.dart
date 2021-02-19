import "dart:convert";

import 'package:flutter/cupertino.dart';

const String _ALPHABET = "0123456789abcdef";

/// An instance of the default implementation of the [HexCodec].
const ColorConverter = const ColorCodec();

/// A codec for encoding and decoding byte arrays to and from
/// hexadecimal strings.
class ColorCodec extends Codec<Color, String> {
  const ColorCodec();

  @override
  Converter<Color, String> get encoder => const HexEncoder();

  @override
  Converter<String, Color> get decoder => const HexDecoder();
}

class HexEncoder extends Converter<Color, String> {
  const HexEncoder();

  @override
  String convert(Color bytes) {
    return bytes.toString();
  }
}

class HexDecoder extends Converter<String, Color> {
  const HexDecoder();

  @override
  Color convert(String hex) {
    if (hex == null) {
      return Color.fromARGB(0, 255, 255, 255);
    }
    String str = hex.replaceAll(" ", "").replaceAll("#", "");
    str = str.toLowerCase();

    if (str.length < 6) {
      str = ('000000' + str);
      str = str.substring(str.length - 6, str.length);
    }
    if (str.length < 8) {
      str = (str + '888').substring(0, 8);
    }

    try {
      int r = int.tryParse(str.substring(0, 2), radix: 16);
      int g = int.tryParse(str.substring(2, 4), radix: 16);
      int b = int.tryParse(str.substring(4, 6), radix: 16);
      int alpha = int.tryParse(str.substring(6, 8), radix: 16);

      Color result = Color.fromARGB(alpha, r, g, b);
      return result;
    } catch (e) {
      return null;
    }
  }
}
