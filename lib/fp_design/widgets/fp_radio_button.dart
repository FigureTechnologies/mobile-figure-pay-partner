part of fp_design;

/// Behaves like RadioListTile, but follows design guidelines
class FpRadioButton<T> extends StatelessWidget {
  /// The value represented by this radio button.
  final T value;

  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;
  final Function()? onTap;
  final Widget title;
  final Widget? description;
  final BorderRadius? borderRadius;

  const FpRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onTap,
    required this.title,
    this.description,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _FpRadioButton(
      value: value,
      groupValue: groupValue,
      onTap: onTap,
      title: title,
    );
  }
}

/// Makes a ListView of FpRadioButtons that are separated with dividers
/// If [radioButtonList] only contains one item, it will look like a single [FpRadioButton]
class FpRadioButtonList<T> extends StatelessWidget {
  const FpRadioButtonList({Key? key, required this.radioButtonList})
      : super(key: key);

  final List<FpRadioButton> radioButtonList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.midGrey),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _FpRadioButton(
              title: radioButtonList[index].title,
              description: radioButtonList[index].description,
              value: radioButtonList[index].value,
              groupValue: radioButtonList[index].groupValue,
              onTap: radioButtonList[index].onTap,
              borderRadius: _getBorderRadius(index, radioButtonList.length),
              activeHighlightBorder: false,
              listItem: true,
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
                thickness: 1,
                height: 0,
                color: Theme.of(context).colorScheme.midGrey);
          },
          itemCount: radioButtonList.length),
    );
  }

  BorderRadius _getBorderRadius(int index, int length) {
    // One or no list items
    if (length <= 1) {
      return const BorderRadius.all(Radius.circular(5));
      // top list item
    } else if (index == 0) {
      return const BorderRadius.vertical(top: Radius.circular(5));
      // bottom list item
    } else if (index == length - 1) {
      return const BorderRadius.vertical(bottom: Radius.circular(5));
    }
    // center list item
    return const BorderRadius.all(Radius.circular(0));
  }
}

/// Private class responsible for creating the Radio based on if it's a single button or in a list of buttons
class _FpRadioButton<T> extends StatelessWidget {
  /// The value represented by this radio button.
  final T value;

  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;
  final Function()? onTap;
  final Widget title;
  final Widget? description;
  final BorderRadius? borderRadius;
  final bool activeHighlightBorder;
  final bool listItem;

  const _FpRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onTap,
    required this.title,
    this.description,
    this.borderRadius,
    this.activeHighlightBorder = true,
    this.listItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(5)),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: Spacing.large, horizontal: Spacing.medium),
        decoration: !listItem
            ? BoxDecoration(
                border: Border.all(
                    color: activeHighlightBorder
                        ? value == groupValue
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.midGrey
                        : Theme.of(context).colorScheme.midGrey),
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(5)))
            : null,
        child: Row(
          children: [
            value == groupValue
                ? FpIcon(
                    FpIcons.radio_filled,
                    color: Theme.of(context).colorScheme.primary4,
                  )
                : FpIcon(
                    FpIcons.radio_unfilled,
                    color: Theme.of(context).colorScheme.midGrey,
                  ),
            const HorizontalSpacer.medium(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (description != null) ...[
                    const VerticalSpacer.small(),
                    description!
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
