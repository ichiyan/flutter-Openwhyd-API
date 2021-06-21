import 'package:flutter/material.dart';

class GradientContainer extends StatefulWidget {
  final Widget child;
  final bool opacity;
  GradientContainer({required this.child, required this.opacity});
  @override
  _GradientContainerState createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? ((widget.opacity == true)
                  ? [
                      Colors.grey[850]!.withOpacity(0.8),
                      Colors.grey[900]!.withOpacity(0.9),
                      Colors.black.withOpacity(1),
                    ]
                  : [
                      Colors.grey[850]!,
                      Colors.grey[900]!,
                      Colors.black,
                    ])
              : [
                  Colors.white,
                  Theme.of(context).canvasColor,
                ],
        ),
      ),
      child: widget.child,
    );
  }
}

class BottomGradientContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  BottomGradientContainer(
      {required this.child,
      required this.margin,
      required this.padding,
      required this.borderRadius});
  @override
  _BottomGradientContainerState createState() =>
      _BottomGradientContainerState();
}

class _BottomGradientContainerState extends State<BottomGradientContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  Colors.grey[850]!,
                  Colors.grey[900]!,
                  Colors.black,
                ]
              : [
                  Colors.white,
                  Theme.of(context).canvasColor,
                ],
        ),
      ),
      child: widget.child,
    );
  }
}

class GradientCard extends StatefulWidget {
  final Widget child;
  GradientCard({required this.child});
  @override
  _GradientCardState createState() => _GradientCardState();
}

class _GradientCardState extends State<GradientCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
                    Colors.grey[850]!,
                    Colors.grey[850]!,
                    Colors.grey[900]!,
                  ]
                : [
                    Colors.white,
                    Theme.of(context).canvasColor,
                  ],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
