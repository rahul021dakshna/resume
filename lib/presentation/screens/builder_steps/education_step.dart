import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/resume_sub_entities.dart';
import '../../providers/resume_provider.dart';

class EducationStep extends ConsumerWidget {
  final String resumeId;
  const EducationStep({super.key, required this.resumeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeState = ref.watch(resumeProvider(resumeId));
    final education = resumeState.education;

    return Scaffold(
      body: education.isEmpty
          ? const Center(child: Text('No education added yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: education.length,
              itemBuilder: (context, index) {
                final edu = education[index];
                return Card(
                  child: ListTile(
                    title: Text(edu.degree),
                    subtitle: Text('${edu.institution} • ${edu.graduationDate}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEducationDialog(context, ref, edu),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => ref.read(resumeProvider(resumeId).notifier).deleteEducation(edu.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEducationDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEducationDialog(BuildContext context, WidgetRef ref, EducationEntity? education) {
    final institutionController = TextEditingController(text: education?.institution);
    final degreeController = TextEditingController(text: education?.degree);
    final graduationDateController = TextEditingController(text: education?.graduationDate);
    final gradeController = TextEditingController(text: education?.grade);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(education == null ? 'Add Education' : 'Edit Education'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: institutionController, decoration: const InputDecoration(labelText: 'Institution')),
            TextField(controller: degreeController, decoration: const InputDecoration(labelText: 'Degree')),
            TextField(controller: graduationDateController, decoration: const InputDecoration(labelText: 'Graduation Date')),
            TextField(controller: gradeController, decoration: const InputDecoration(labelText: 'Grade')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final resumeState = ref.read(resumeProvider(resumeId));
              final actualResumeId = resumeState.resume!.id;

              final newEdu = EducationEntity(
                id: education?.id ?? const Uuid().v4(),
                resumeId: actualResumeId,
                institution: institutionController.text,
                degree: degreeController.text,
                graduationDate: graduationDateController.text,
                grade: gradeController.text,
              );
              ref.read(resumeProvider(resumeId).notifier).saveEducation(newEdu);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
