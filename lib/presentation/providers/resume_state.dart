import '../../domain/entities/resume_entity.dart';
import '../../domain/entities/resume_sub_entities.dart';

class ResumeState {
  final ResumeEntity? resume;
  final List<ExperienceEntity> experiences;
  final List<EducationEntity> education;
  final List<SkillEntity> skills;
  final List<ProjectEntity> projects;
  final List<CertificationEntity> certifications;
  final List<LanguageEntity> languages;
  final bool isLoading;

  ResumeState({
    this.resume,
    this.experiences = const [],
    this.education = const [],
    this.skills = const [],
    this.projects = const [],
    this.certifications = const [],
    this.languages = const [],
    this.isLoading = false,
  });

  ResumeState copyWith({
    ResumeEntity? resume,
    List<ExperienceEntity>? experiences,
    List<EducationEntity>? education,
    List<SkillEntity>? skills,
    List<ProjectEntity>? projects,
    List<CertificationEntity>? certifications,
    List<LanguageEntity>? languages,
    bool? isLoading,
  }) {
    return ResumeState(
      resume: resume ?? this.resume,
      experiences: experiences ?? this.experiences,
      education: education ?? this.education,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      certifications: certifications ?? this.certifications,
      languages: languages ?? this.languages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
