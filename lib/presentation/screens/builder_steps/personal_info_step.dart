import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/resume_provider.dart';
import '../../providers/service_provider.dart';

class PersonalInfoStep extends ConsumerStatefulWidget {
  final String resumeId;
  const PersonalInfoStep({super.key, required this.resumeId});

  @override
  ConsumerState<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends ConsumerState<PersonalInfoStep> {
  late TextEditingController _fullNameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _linkedinController;
  late TextEditingController _portfolioController;
  late TextEditingController _summaryController;

  @override
  void initState() {
    super.initState();
    final resumeState = ref.read(resumeProvider(widget.resumeId));
    final resume = resumeState.resume;
    _fullNameController = TextEditingController(text: resume?.fullName);
    _jobTitleController = TextEditingController(text: resume?.jobTitle);
    _emailController = TextEditingController(text: resume?.email);
    _phoneController = TextEditingController(text: resume?.phone);
    _addressController = TextEditingController(text: resume?.address);
    _linkedinController = TextEditingController(text: resume?.linkedin);
    _portfolioController = TextEditingController(text: resume?.portfolio);
    _summaryController = TextEditingController(text: resume?.summary);
  }

  void _saveData() {
    final resumeState = ref.read(resumeProvider(widget.resumeId));
    final resume = resumeState.resume;
    if (resume != null) {
      final updatedResume = resume.copyWith(
        fullName: _fullNameController.text,
        jobTitle: _jobTitleController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        linkedin: _linkedinController.text,
        portfolio: _portfolioController.text,
        summary: _summaryController.text,
        updatedAt: DateTime.now(),
      );
      ref.read(resumeProvider(widget.resumeId).notifier).updateResume(updatedResume);
    }
  }

  Future<void> _improveSummary() async {
    final aiService = ref.read(aiServiceProvider);
    final improved = await aiService.improveSummary(_summaryController.text);
    setState(() {
      _summaryController.text = improved;
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTextField('Full Name', _fullNameController),
          _buildTextField('Job Title', _jobTitleController),
          _buildTextField('Email', _emailController),
          _buildTextField('Phone', _phoneController),
          _buildTextField('Address', _addressController),
          _buildTextField('LinkedIn', _linkedinController),
          _buildTextField('Portfolio', _portfolioController),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Professional Summary', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton.icon(
                onPressed: _improveSummary,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Improve with AI'),
              ),
            ],
          ),
          TextField(
            controller: _summaryController,
            maxLines: 5,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            onChanged: (_) => _saveData(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        onChanged: (_) => _saveData(),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _linkedinController.dispose();
    _portfolioController.dispose();
    _summaryController.dispose();
    super.dispose();
  }
}
