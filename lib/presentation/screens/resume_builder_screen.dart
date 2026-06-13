import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/resume_provider.dart';
import 'builder_steps/personal_info_step.dart';
import 'builder_steps/experience_step.dart';
import 'builder_steps/education_step.dart';
import 'builder_steps/skills_step.dart';

class ResumeBuilderScreen extends ConsumerStatefulWidget {
  final String resumeId;
  const ResumeBuilderScreen({super.key, required this.resumeId});

  @override
  ConsumerState<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends ConsumerState<ResumeBuilderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final resumeState = ref.watch(resumeProvider(widget.resumeId));

    if (resumeState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(resumeState.resume?.title ?? 'Resume Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () => context.push('/preview/${widget.resumeId}'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Personal'),
            Tab(text: 'Experience'),
            Tab(text: 'Education'),
            Tab(text: 'Skills'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PersonalInfoStep(resumeId: widget.resumeId),
          ExperienceStep(resumeId: widget.resumeId),
          EducationStep(resumeId: widget.resumeId),
          SkillsStep(resumeId: widget.resumeId),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
