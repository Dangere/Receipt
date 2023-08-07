import 'package:flutter/material.dart';

class SlideUpPanel extends StatefulWidget {
  const SlideUpPanel(
      {super.key,
      required this.body,
      required this.panel,
      required this.isOpen,
      required this.duration,});

  final Widget body;
  final Widget panel;
  final bool isOpen;
  final Duration duration;

  @override
  State<SlideUpPanel> createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        widget.body,
        AnimatedSlide(
          offset: widget.isOpen ? Offset.zero : const Offset(0, 1),
          curve: Curves.ease,
          duration: widget.duration,
          child: widget.panel,
        )
      ],
    );
  }
}
