import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../providers/resume_provider.dart';
import '../../templates/template_engine.dart';

class ResumePreviewScreen extends ConsumerWidget {
  final String resumeId;
  const ResumePreviewScreen({super.key, required this.resumeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeState = ref.watch(resumeProvider(resumeId));

    if (resumeState.resume == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
      ),
      body: PdfPreview(
        build: (format) async {
          final engine = TemplateEngine();
          final pdf = await engine.generatePdf(resumeState);
          return pdf.save();
        },
        onPrinted: (context) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Printed successfully')),
        ),
        onShared: (context) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shared successfully')),
        ),
      ),
    );
  }
}
