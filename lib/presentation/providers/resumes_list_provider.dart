import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/resume_entity.dart';
import '../../domain/repositories/resume_repository.dart';
import 'repository_provider.dart';

class ResumesListNotifier extends StateNotifier<AsyncValue<List<ResumeEntity>>> {
  final ResumeRepository _repository;

  ResumesListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadResumes();
  }

  Future<void> loadResumes() async {
    state = const AsyncValue.loading();
    try {
      final resumes = await _repository.getAllResumes();
      state = AsyncValue.data(resumes);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteResume(String id) async {
    await _repository.deleteResume(id);
    loadResumes();
  }
}

final resumesListProvider = StateNotifierProvider<ResumesListNotifier, AsyncValue<List<ResumeEntity>>>((ref) {
  final repository = ref.watch(resumeRepositoryProvider);
  return ResumesListNotifier(repository);
});
