import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ViewAttachment extends StatefulWidget {
  final String endereco;

  ViewAttachment(this.endereco);

  @override
  _ViewAttachmentState createState() => _ViewAttachmentState(this.endereco);
}

class _ViewAttachmentState extends State<ViewAttachment> {
  final String endereco;
  bool _isLoading = true;
  PDFDocument document;
  _ViewAttachmentState(this.endereco);

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    if (!kIsWeb) {
      document = await PDFDocument.fromURL(endereco);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : viewPdf(),
        ),
      ),
    );
  }

  Widget viewPdf() {
    if (!kIsWeb) {
      return PDFViewer(
        document: document,
        zoomSteps: 1,
      );
    } else {
      return SfPdfViewer.network(endereco);
    }
  }
}
