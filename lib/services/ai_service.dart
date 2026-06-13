import 'package:google_generative_ai/google_generative_ai.dart';
import 'secure_storage_service.dart';

class AiService {
  final SecureStorageService _secureStorage;

  AiService(this._secureStorage);

  Future<GenerativeModel?> _getModel() async {
    final apiKey = await _secureStorage.getApiKey();
    if (apiKey == null || apiKey.isEmpty) return null;
    return GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<String> improveSummary(String summary) async {
    final model = await _getModel();
    if (model == null) return summary;

    final prompt = 'Improve this professional summary for a resume: $summary. Keep it concise and professional.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text ?? summary;
  }

  Future<String> rewriteExperience(String experience) async {
    final model = await _getModel();
    if (model == null) return experience;

    final prompt = 'Rewrite these job responsibilities and achievements to be more impactful and professional: $experience';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text ?? experience;
  }

  Future<String> suggestSkills(String jobTitle, String experience) async {
    final model = await _getModel();
    if (model == null) return '';

    final prompt = 'Based on the job title "$jobTitle" and experience "$experience", suggest a list of 5 key skills for a resume. Return only a comma-separated list.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text ?? '';
  }

  Future<String> optimizeForAts(String content) async {
    final model = await _getModel();
    if (model == null) return content;

    final prompt = 'Optimize this resume content for ATS (Applicant Tracking Systems) by using professional keywords: $content';
    final [text] = [Content.text(prompt)];
    final response = await model.generateContent([text]);
    return response.text ?? content;
  }
}
