import 'package:flutter/material.dart';

import '../../../theme/spacing.dart';

class ShimmerCard extends StatelessWidget {
  final double height;

  const ShimmerCard({super.key, this.height = 120});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: base,
      ),
      child: Center(
        child: _ShimmerBar(width: 120),
      ),
    );
  }
}

class _ShimmerBar extends StatefulWidget {
  final double width;
  const _ShimmerBar({required this.width});

  @override
  State<_ShimmerBar> createState() => _ShimmerBarState();
}

class _ShimmerBarState extends State<_ShimmerBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pos = _controller.value;
        return Container(
          width: widget.width,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              colors: [
                Colors.grey.withValues(alpha: 0.1),
                Colors.grey.withValues(alpha: 0.2),
                Colors.grey.withValues(alpha: 0.1),
              ],
              stops: [pos - 0.3, pos, pos + 0.3].map((s) => s.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  final int count;
  final double height;
  final double spacing;

  const ShimmerGrid({
    super.key,
    this.count = 2,
    this.height = 130,
    this.spacing = AppSpacing.sm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: List.generate(count, (_) => SizedBox(
          width: (MediaQuery.of(context).size.width - AppSpacing.lg * 2 - spacing) / 2,
          child: ShimmerCard(height: height),
        )),
      ),
    );
  }
}
