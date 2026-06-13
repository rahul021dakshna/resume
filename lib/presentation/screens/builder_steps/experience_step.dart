import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/resume_sub_entities.dart';
import '../../providers/resume_provider.dart';
import '../../providers/service_provider.dart';

class ExperienceStep extends ConsumerWidget {
  final String resumeId;
  const ExperienceStep({super.key, required this.resumeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeState = ref.watch(resumeProvider(resumeId));
    final experiences = resumeState.experiences;

    return Scaffold(
      body: experiences.isEmpty
          ? const Center(child: Text('No experience added yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                return Card(
                  child: ListTile(
                    title: Text(exp.position),
                    subtitle: Text('${exp.company} • ${exp.duration}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showExperienceDialog(context, ref, exp),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => ref.read(resumeProvider(resumeId).notifier).deleteExperience(exp.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExperienceDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showExperienceDialog(BuildContext context, WidgetRef ref, ExperienceEntity? experience) {
    final companyController = TextEditingController(text: experience?.company);
    final positionController = TextEditingController(text: experience?.position);
    final durationController = TextEditingController(text: experience?.duration);
    final responsibilitiesController = TextEditingController(text: experience?.responsibilities);
    final achievementsController = TextEditingController(text: experience?.achievements);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(experience == null ? 'Add Experience' : 'Edit Experience'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: companyController, decoration: const InputDecoration(labelText: 'Company')),
              TextField(controller: positionController, decoration: const InputDecoration(labelText: 'Position')),
              TextField(controller: durationController, decoration: const InputDecoration(labelText: 'Duration')),
              TextField(
                controller: responsibilitiesController,
                decoration: const InputDecoration(labelText: 'Responsibilities'),
                maxLines: 3,
              ),
              Row(
                children: [
                  const Text('Achievements'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.auto_awesome),
                    onPressed: () async {
                      final aiService = ref.read(aiServiceProvider);
                      final improved = await aiService.rewriteExperience(responsibilitiesController.text);
                      achievementsController.text = improved;
                    },
                  ),
                ],
              ),
              TextField(
                controller: achievementsController,
                decoration: const InputDecoration(labelText: 'Achievements'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final resumeState = ref.read(resumeProvider(resumeId));
              final actualResumeId = resumeState.resume!.id;
              
              final newExp = ExperienceEntity(
                id: experience?.id ?? const Uuid().v4(),
                resumeId: actualResumeId,
                company: companyController.text,
                position: positionController.text,
                duration: durationController.text,
                responsibilities: responsibilitiesController.text,
                achievements: achievementsController.text,
              );
              ref.read(resumeProvider(resumeId).notifier).saveExperience(newExp);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
