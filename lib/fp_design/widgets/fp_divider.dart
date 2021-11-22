part of fp_design;

class FpDivider extends StatelessWidget with FpColorMixin {
  const FpDivider({
    Key? key,
    this.thickness = 1.0,
    this.color = FpColor.lightGrey,
    this.padding,
  }) : super(key: key);

  final double thickness;

  @override
  final FpColor? color;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      color: getColor(context),
      thickness: thickness,
      height: 0,
    );

    return padding == null
        ? divider
        : Padding(
            padding: padding!,
            child: divider,
          );
  }
}
