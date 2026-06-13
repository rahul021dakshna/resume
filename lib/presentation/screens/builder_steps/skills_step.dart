import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/resume_sub_entities.dart';
import '../../providers/resume_provider.dart';

class SkillsStep extends ConsumerWidget {
  final String resumeId;
  const SkillsStep({super.key, required this.resumeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeState = ref.watch(resumeProvider(resumeId));
    final skills = resumeState.skills;

    return Scaffold(
      body: skills.isEmpty
          ? const Center(child: Text('No skills added yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                return Card(
                  child: ListTile(
                    title: Text(skill.name),
                    subtitle: LinearProgressIndicator(value: skill.level),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showSkillDialog(context, ref, skill),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => ref.read(resumeProvider(resumeId).notifier).deleteSkill(skill.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSkillDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSkillDialog(BuildContext context, WidgetRef ref, SkillEntity? skill) {
    final nameController = TextEditingController(text: skill?.name);
    double level = skill?.level ?? 0.5;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(skill == null ? 'Add Skill' : 'Edit Skill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Skill Name')),
              const SizedBox(height: 16),
              const Text('Proficiency Level'),
              Slider(
                value: level,
                onChanged: (val) => setState(() => level = val),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final resumeState = ref.read(resumeProvider(resumeId));
                final actualResumeId = resumeState.resume!.id;

                final newSkill = SkillEntity(
                  id: skill?.id ?? const Uuid().v4(),
                  resumeId: actualResumeId,
                  name: nameController.text,
                  level: level,
                );
                ref.read(resumeProvider(resumeId).notifier).saveSkill(newSkill);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
