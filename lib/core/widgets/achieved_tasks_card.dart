import 'dart:math';
import 'package:flutter/material.dart';

class AchievedTasksCard extends StatelessWidget {
  const AchievedTasksCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.progress,
    required this.percentage,
  });

  final int completedTasks;
  final int totalTasks;
  final double progress;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '$completedTasks Out of $totalTasks Done',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Theme.of(context).dividerColor,
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
