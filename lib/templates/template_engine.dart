import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../domain/entities/resume_entity.dart';
import '../domain/entities/resume_sub_entities.dart';
import '../presentation/providers/resume_state.dart';

class TemplateEngine {
  Future<pw.Document> generatePdf(ResumeState state) async {
    final pdf = pw.Document();

    final resume = state.resume!;
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(resume),
            pw.SizedBox(height: 20),
            _buildSummary(resume),
            pw.SizedBox(height: 20),
            _buildExperience(state.experiences),
            pw.SizedBox(height: 20),
            _buildEducation(state.education),
            pw.SizedBox(height: 20),
            _buildSkills(state.skills),
          ];
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildHeader(ResumeEntity resume) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(resume.fullName, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.Text(resume.jobTitle, style: pw.TextStyle(fontSize: 16, color: PdfColors.grey700)),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(resume.email),
            pw.Text(resume.phone),
          ],
        ),
        pw.Text(resume.address),
      ],
    );
  }

  pw.Widget _buildSummary(ResumeEntity resume) {
    if (resume.summary.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Professional Summary', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),
        pw.Text(resume.summary),
      ],
    );
  }

  pw.Widget _buildExperience(List<ExperienceEntity> experiences) {
    if (experiences.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Work Experience', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),
        ...experiences.map((exp) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 12),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(exp.position, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text(exp.duration),
                ],
              ),
              pw.Text(exp.company, style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
              pw.Bullet(text: exp.responsibilities),
              if (exp.achievements.isNotEmpty) pw.Bullet(text: 'Key Achievement: ${exp.achievements}'),
            ],
          ),
        )),
      ],
    );
  }

  pw.Widget _buildEducation(List<EducationEntity> education) {
    if (education.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Education', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),
        ...education.map((edu) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(edu.degree, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text(edu.graduationDate),
                ],
              ),
              pw.Text(edu.institution),
            ],
          ),
        )),
      ],
    );
  }

  pw.Widget _buildSkills(List<SkillEntity> skills) {
    if (skills.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Skills', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),
        pw.Wrap(
          spacing: 10,
          runSpacing: 5,
          children: skills.map((skill) => pw.Text('${skill.name} (${(skill.level * 100).toInt()}%)')).toList(),
        ),
      ],
    );
  }
}
