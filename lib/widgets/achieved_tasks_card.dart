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
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Achieved Tasks',
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$completedTasks Out of $totalTasks Done',
                style: const TextStyle(
                  color: Color(0xFFC6C6C6),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
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
                    backgroundColor: const Color(0xFF6D6D6D),
                    color: const Color(0xFF15B86C),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFCFC),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}