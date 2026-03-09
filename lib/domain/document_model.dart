enum DocumentType { pdf, docx, txt, other }

class DocumentModel {
  final String name;
  final String path;
  final int size;
  final DateTime lastModified;
  final DocumentType type;

  DocumentModel({
    required this.name,
    required this.path,
    required this.size,
    required this.lastModified,
    required this.type,
  });
}
