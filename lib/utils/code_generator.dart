import 'dart:math';

class CodeGenerator {
  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  static String randomCode({int length = 6}) {
    final rand = Random.secure();
    return List.generate(length, (index) => _chars[rand.nextInt(_chars.length)]).join();
  }
}
