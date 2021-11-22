part of fp_design;

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer._(
    this._height, {
    Key? key,
  }) : super(key: key);

  const VerticalSpacer.xSmall({Key? key}) : this._(Spacing.xSmall, key: key);
  const VerticalSpacer.small({Key? key}) : this._(Spacing.small, key: key);
  const VerticalSpacer.medium({Key? key}) : this._(Spacing.medium, key: key);
  const VerticalSpacer.large({Key? key}) : this._(Spacing.large, key: key);
  const VerticalSpacer.xLarge({Key? key}) : this._(Spacing.xLarge, key: key);
  const VerticalSpacer.xxLarge({Key? key}) : this._(Spacing.xxLarge, key: key);

  final double? _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: _height);
  }
}

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer._(
    this._width, {
    Key? key,
  }) : super(key: key);

  const HorizontalSpacer.xSmall({Key? key}) : this._(Spacing.xSmall, key: key);
  const HorizontalSpacer.small({Key? key}) : this._(Spacing.small, key: key);
  const HorizontalSpacer.medium({Key? key}) : this._(Spacing.medium, key: key);
  const HorizontalSpacer.large({Key? key}) : this._(Spacing.large, key: key);
  const HorizontalSpacer.xLarge({Key? key}) : this._(Spacing.xLarge, key: key);
  const HorizontalSpacer.xxLarge({Key? key})
      : this._(Spacing.xxLarge, key: key);

  final double? _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: _width);
  }
}
