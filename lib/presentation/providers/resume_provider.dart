import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/resume_entity.dart';
import '../../domain/entities/resume_sub_entities.dart';
import '../../domain/repositories/resume_repository.dart';
import 'repository_provider.dart';
import 'resume_state.dart';

class ResumeNotifier extends StateNotifier<ResumeState> {
  final ResumeRepository _repository;

  ResumeNotifier(this._repository) : super(ResumeState());

  Future<void> loadResume(String id) async {
    if (id == 'new') {
      final newId = const Uuid().v4();
      final newResume = ResumeEntity(
        id: newId,
        title: 'Untitled Resume',
        fullName: '',
        jobTitle: '',
        email: '',
        phone: '',
        address: '',
        linkedin: '',
        portfolio: '',
        summary: '',
        templateId: 'modern',
        updatedAt: DateTime.now(),
      );
      state = ResumeState(resume: newResume);
      await _repository.saveResume(newResume);
      return;
    }

    state = state.copyWith(isLoading: true);
    final resume = await _repository.getResumeById(id);
    if (resume != null) {
      final experiences = await _repository.getExperiences(id);
      final education = await _repository.getEducation(id);
      final skills = await _repository.getSkills(id);
      final projects = await _repository.getProjects(id);
      final certifications = await _repository.getCertifications(id);
      final languages = await _repository.getLanguages(id);

      state = ResumeState(
        resume: resume,
        experiences: experiences,
        education: education,
        skills: skills,
        projects: projects,
        certifications: certifications,
        languages: languages,
        isLoading: false,
      );
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateResume(ResumeEntity updatedResume) async {
    state = state.copyWith(resume: updatedResume);
    await _repository.saveResume(updatedResume);
  }

  // Experiences
  Future<void> saveExperience(ExperienceEntity experience) async {
    await _repository.saveExperience(experience);
    final experiences = await _repository.getExperiences(state.resume!.id);
    state = state.copyWith(experiences: experiences);
  }

  Future<void> deleteExperience(String id) async {
    await _repository.deleteExperience(id);
    final experiences = await _repository.getExperiences(state.resume!.id);
    state = state.copyWith(experiences: experiences);
  }

  // Education
  Future<void> saveEducation(EducationEntity education) async {
    await _repository.saveEducation(education);
    final list = await _repository.getEducation(state.resume!.id);
    state = state.copyWith(education: list);
  }

  Future<void> deleteEducation(String id) async {
    await _repository.deleteEducation(id);
    final list = await _repository.getEducation(state.resume!.id);
    state = state.copyWith(education: list);
  }

  // Skills
  Future<void> saveSkill(SkillEntity skill) async {
    await _repository.saveSkill(skill);
    final list = await _repository.getSkills(state.resume!.id);
    state = state.copyWith(skills: list);
  }

  Future<void> deleteSkill(String id) async {
    await _repository.deleteSkill(id);
    final list = await _repository.getSkills(state.resume!.id);
    state = state.copyWith(skills: list);
  }
}

final resumeProvider = StateNotifierProvider.family<ResumeNotifier, ResumeState, String>((ref, id) {
  final repository = ref.watch(resumeRepositoryProvider);
  final notifier = ResumeNotifier(repository);
  notifier.loadResume(id);
  return notifier;
});
