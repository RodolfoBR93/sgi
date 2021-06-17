import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

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
    document = await PDFDocument.fromURL(endereco);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                ),
        ),
      ),
    );
  }
}
