import '../entities/resume_entity.dart';
import '../entities/resume_sub_entities.dart';

abstract class ResumeRepository {
  // Resume CRUD
  Future<List<ResumeEntity>> getAllResumes();
  Future<ResumeEntity?> getResumeById(String id);
  Future<void> saveResume(ResumeEntity resume);
  Future<void> deleteResume(String id);
  Future<void> duplicateResume(String id, String newId);

  // Experience CRUD
  Future<List<ExperienceEntity>> getExperiences(String resumeId);
  Future<void> saveExperience(ExperienceEntity experience);
  Future<void> deleteExperience(String id);

  // Education CRUD
  Future<List<EducationEntity>> getEducation(String resumeId);
  Future<void> saveEducation(EducationEntity education);
  Future<void> deleteEducation(String id);

  // Skill CRUD
  Future<List<SkillEntity>> getSkills(String resumeId);
  Future<void> saveSkill(SkillEntity skill);
  Future<void> deleteSkill(String id);

  // Project CRUD
  Future<List<ProjectEntity>> getProjects(String resumeId);
  Future<void> saveProject(ProjectEntity project);
  Future<void> deleteProject(String id);

  // Certification CRUD
  Future<List<CertificationEntity>> getCertifications(String resumeId);
  Future<void> saveCertification(CertificationEntity certification);
  Future<void> deleteCertification(String id);

  // Language CRUD
  Future<List<LanguageEntity>> getLanguages(String resumeId);
  Future<void> saveLanguage(LanguageEntity language);
  Future<void> deleteLanguage(String id);
}
