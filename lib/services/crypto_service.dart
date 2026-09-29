// خدمة التشفير البسيطة باستخدام مكتبة encrypt وflutter_secure_storage

import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt_pkg;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CryptoService {
  static const _keyStorageKey = 'master_key';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // يولد مفتاح AES عشوائي ويخزنه بأمان
  Future<encrypt_pkg.Key> _getOrCreateKey() async {
    final existing = await _secureStorage.read(key: _keyStorageKey);
    if (existing != null) {
      final bytes = base64Decode(existing);
      return encrypt_pkg.Key(Uint8List.fromList(bytes));
    }

    final key = encrypt_pkg.Key.fromSecureRandom(32);
    await _secureStorage.write(key: _keyStorageKey, value: base64Encode(key.bytes));
    return key;
  }

  Future<String> encryptBytes(List<int> data) async {
    final key = await _getOrCreateKey();
    final iv = encrypt_pkg.IV.fromLength(16);
    final encrypter = encrypt_pkg.Encrypter(encrypt_pkg.AES(key));
    final encrypted = encrypter.encryptBytes(data, iv: iv);
    return base64Encode(encrypted.bytes);
  }

  Future<List<int>> decryptToBytes(String base64Data) async {
    final key = await _getOrCreateKey();
    final iv = encrypt_pkg.IV.fromLength(16);
    final encrypter = encrypt_pkg.Encrypter(encrypt_pkg.AES(key));
    final bytes = base64Decode(base64Data);
    final enc = encrypt_pkg.Encrypted(bytes);
    final decrypted = encrypter.decryptBytes(enc, iv: iv);
    return decrypted;
  }
}
