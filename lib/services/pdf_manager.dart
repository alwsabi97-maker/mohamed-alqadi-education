// إدارة ملفات PDF — تحميل من الذاكرة، تشفير وتخزين داخل مجلد التطبيق

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'crypto_service.dart';

class PdfManager {
  final CryptoService crypto = CryptoService();

  // يفتح منتقي الملفات للسماح للمعلم باختيار PDF
  Future<String?> pickAndStoreEncryptedPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null || result.files.isEmpty) return null;
    final fileBytes = result.files.first.bytes;
    final fileName = result.files.first.name;

    if (fileBytes == null) {
      // في بعض الأجهزة قد تحصل على المسار بدل البايتات
      final path = result.files.first.path;
      if (path == null) return null;
      final bytes = await File(path).readAsBytes();
      return await _encryptAndSave(bytes, fileName);
    }

    return await _encryptAndSave(fileBytes, fileName);
  }

  Future<String> _encryptAndSave(List<int> bytes, String name) async {
    final encrypted = await crypto.encryptBytes(bytes);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/encrypted_$name.enc');
    await file.writeAsString(encrypted);
    return file.path;
  }

  // لفك التشفير مؤقتًا وإرجاع مسار ملف PDF مؤقت للعرض
  Future<String?> decryptToTempFile(String encryptedPath) async {
    final file = File(encryptedPath);
    if (!await file.exists()) return null;
    final content = await file.readAsString();
    final bytes = await crypto.decryptToBytes(content);
    final tempDir = await getTemporaryDirectory();
    final out = File('${tempDir.path}/temp_preview.pdf');
    await out.writeAsBytes(bytes, flush: true);
    return out.path;
  }
}
