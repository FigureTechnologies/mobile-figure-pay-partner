part of fp_design;

class FpText extends StatelessWidget with FpTextStyleMixin, FpColorMixin {
  const FpText(
    this.data, {
    Key? key,
    this.style = FpTextStyle.m,
    this.color,
    this.overflow,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.lineThrough = false,
    this.underline = false,
  }) : super(key: key);

  /// The text to display.
  final String data;

  @override
  final FpTextStyle style;

  @override
  final FpColor? color;

  final TextOverflow? overflow;
  final TextAlign textAlign;
  final int? maxLines;
  final bool lineThrough;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: _getStyle(context),
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    var style = color == null
        ? textStyle(context)
        : textStyle(context)?.copyWith(color: getColor(context));

    return lineThrough
        ? style?.copyWith(decoration: TextDecoration.lineThrough)
        : underline
            ? style?.copyWith(decoration: TextDecoration.underline)
            : style;
  }
}
