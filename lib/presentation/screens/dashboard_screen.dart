import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/resumes_list_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumesAsync = ref.watch(resumesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resumes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: resumesAsync.when(
        data: (resumes) => resumes.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('No resumes yet. Create your first one!'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.push('/builder/new'),
                      child: const Text('Create New Resume'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: resumes.length,
                itemBuilder: (context, index) {
                  final resume = resumes[index];
                  return Card(
                    child: ListTile(
                      title: Text(resume.fullName.isEmpty ? resume.title : resume.fullName),
                      subtitle: Text('Last updated: ${DateFormat.yMMMd().format(resume.updatedAt)}'),
                      onTap: () => context.push('/builder/${resume.id}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => ref.read(resumesListProvider.notifier).deleteResume(resume.id),
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: resumesAsync.maybeWhen(
        data: (resumes) => resumes.isNotEmpty
            ? FloatingActionButton(
                onPressed: () => context.push('/builder/new'),
                child: const Icon(Icons.add),
              )
            : null,
        orElse: () => null,
      ),
    );
  }
}
