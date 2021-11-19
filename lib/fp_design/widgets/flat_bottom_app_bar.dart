part of fp_design;

/// A [BottomAppBar] with 0.0 [elevation] and default transparent [color]
/// commonly used as [bottomNavigationBar] with buttom
class FlatBottomAppBar extends StatelessWidget {
  const FlatBottomAppBar({
    Key? key,
    required this.child,
    this.color = Colors.transparent,
    this.minimum = const EdgeInsets.only(
      bottom: Spacing.xxLarge,
    ),
  }) : super(key: key);

  final Widget child;
  final Color color;

  /// This minimum padding to apply.
  ///
  /// The greater of the minimum insets and the media padding will be applied.
  final EdgeInsets minimum;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: minimum,
      child: BottomAppBar(
        color: color,
        elevation: 0,
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ),
    );
  }
}
