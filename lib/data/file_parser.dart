import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:voicedocreader/domain/document_model.dart';

class FileParser {
  static Future<String> extractText(String path, DocumentType type) async {
    final file = File(path);
    if (!await file.exists()) return "File not found";

    try {
      switch (type) {
        case DocumentType.pdf:
          final PdfDocument document = PdfDocument(inputBytes: await file.readAsBytes());
          final String text = PdfTextExtractor(document).extractText();
          document.dispose();
          return text;
        case DocumentType.docx:
          final bytes = await file.readAsBytes();
          return docxToText(bytes);
        case DocumentType.txt:
          return await file.readAsString();
        default:
          return "Unsupported file type";
      }
    } catch (e) {
      return "Error extracting text: $e";
    }
  }
}
