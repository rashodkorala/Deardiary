import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<File> generatePdf(List<Map<String, dynamic>> entries) async {
    final pdf = pw.Document();

    // Add content to the PDF
    for (final entry in entries) {
      pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Date: ${entry['date']}'),
            pw.Text('Content: ${entry['content']}'),
            pw.Text('Rating: ${entry['rating']}'),
            pw.SizedBox(height: 16),
          ],
        ),
      ));
    }

    // Save the PDF to a temporary file
    final pdfFile =
        File('/Users/rashodkorala/Downloads/deardiary/assets/pdf/diary.pdf');
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfFile;
  }
}
