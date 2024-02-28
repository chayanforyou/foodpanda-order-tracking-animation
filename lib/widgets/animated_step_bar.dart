import 'package:flutter/material.dart';

class AnimatedStepBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double padding;
  final double height;
  final List<double>? stepWidths;
  final Color selectedColor;
  final Color unselectedColor;
  final double fallbackLength;
  final Radius? roundedEdges;
  final Duration duration;

  const AnimatedStepBar({
    required this.totalSteps,
    this.stepWidths,
    this.roundedEdges,
    this.height = 4.0,
    this.currentStep = 0,
    this.selectedColor = Colors.pink,
    this.unselectedColor = Colors.grey,
    this.padding = 3.0,
    this.fallbackLength = 100.0,
    this.duration = const Duration(milliseconds: 1500),
    Key? key,
  })  : assert(
            totalSteps > 0, "Number of total steps (totalSteps) of the StepProgressIndicator must be greater than 0"),
        assert(currentStep >= 0,
            "Current step (currentStep) of the StepProgressIndicator must be greater than or equal to 0"),
        assert(padding >= 0.0, "Padding (padding) of the StepProgressIndicator must be greater or equal to 0"),
        assert(stepWidths == null || stepWidths.length == totalSteps,
            "Step widths (stepWidths) list should have the same length of total steps"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => SizedBox(
        width: constraints.maxWidth != double.infinity ? double.infinity : fallbackLength,
        height: height,
        child: LayoutBuilder(
          builder: (ctx, constraints) => Row(
            children: _buildSteps(
              _maxDefinedSize(constraints.maxWidth),
            ),
          ),
        ),
      ),
    );
  }

  /// Compute the maximum possible size of the indicator between
  /// [height], [selectedSize], [unselectedSize], and [customSize]
  List<double> _maxDefinedSize(double maxSize) {
    if (stepWidths == null) {
      return List.filled(totalSteps, _stepWidthValue(maxSize));
    }

    return _calculateWeights(_maxWidthValue(maxSize) - (padding * 2 * totalSteps), stepWidths!);
  }

  /// Compute single step length, based on total length available
  double _stepWidthValue(double maxSize) => (_maxWidthValue(maxSize) - (padding * 2 * totalSteps)) / totalSteps;

  /// Total length available for the indicator
  double _maxWidthValue(double maxSize) => maxSize != double.infinity ? maxSize : fallbackLength;

  /// Calculates step weight based on the provided weights
  List<double> _calculateWeights(double totalWeight, List<double> weights) {
    double sumRatio = weights.reduce((value, element) => value + element);
    return weights.map((value) => (value / sumRatio) * totalWeight).toList();
  }

  /// Choose what [Color] to assign
  /// given current [step] index (zero-based)
  Color _chooseStepColor(int step, int stepIndex) {
    final isUnselectedStepColor = step > currentStep;

    if (isUnselectedStepColor) {
      return unselectedColor;
    } else {
      return selectedColor;
    }
  }

  /// Build the list of [_ProgressBar],
  /// based on number of [totalSteps]
  List<Widget> _buildSteps(List<double> stepLength) {
    List<Widget> stepList = [];

    int step = 0;

    for (; step < totalSteps; ++step) {
      final loopStep = step + 1;
      final stepColor = _chooseStepColor(loopStep, step);

      if (loopStep == currentStep) {
        stepList.add(
          _AnimatedBar(
            width: stepLength[step],
            height: height,
            padding: padding,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
            roundedEdges: roundedEdges,
            duration: duration,
          ),
        );
      } else {
        stepList.add(
          _ProgressBar(
            width: stepLength[step],
            height: height,
            padding: padding,
            color: stepColor,
            roundedEdges: roundedEdges,
          ),
        );
      }

/*      final progressStep = _ProgressBar(
        width: stepLength[step],
        height: height,
        padding: padding,
        color: stepColor,
        roundedEdges: roundedEdges,
      );

      stepList.add(progressStep);*/
    }

    return stepList;
  }
}

/// Single step of the indicator
class _ProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final double padding;
  final Color color;
  final Radius? roundedEdges;

  const _ProgressBar({
    Key? key,
    required this.width,
    required this.height,
    required this.padding,
    required this.color,
    this.roundedEdges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: roundedEdges != null
          ? ClipRRect(
              borderRadius: BorderRadius.all(roundedEdges!),
              child: _buildStep,
            )
          : _buildStep,
    );
  }

  Widget get _buildStep => _stepContainer(color);

  Widget _stepContainer([Color? color]) => Container(
        width: width,
        height: height,
        color: color,
      );
}

class _AnimatedBar extends StatefulWidget {
  final double width;
  final double height;
  final double padding;
  final Color selectedColor;
  final Color unselectedColor;
  final Radius? roundedEdges;
  final Duration? duration;

  const _AnimatedBar({
    Key? key,
    required this.width,
    required this.height,
    required this.padding,
    required this.selectedColor,
    required this.unselectedColor,
    this.roundedEdges,
    this.duration,
  }) : super(key: key);

  @override
  State<_AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<_AnimatedBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (_controller.isAnimating) setState(() {});
      })
      ..repeat();
    _animation = CurveTween(curve: Curves.easeInOut).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding),
      child: Stack(
        children: [
          Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: widget.roundedEdges != null ? BorderRadius.all(widget.roundedEdges!) : BorderRadius.zero,
              color: widget.unselectedColor,
            ),
          ),
          Opacity(
            opacity: 1.0 - _animation.value,
            child: Container(
              height: widget.height,
              width: widget.width * _animation.value,
              decoration: BoxDecoration(
                borderRadius: widget.roundedEdges != null ? BorderRadius.all(widget.roundedEdges!) : BorderRadius.zero,
                color: widget.selectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
