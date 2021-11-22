part of fp_design;

class TransferRow extends StatelessWidget {
  const TransferRow(
    this.label,
    this.value, {
    Key? key,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FpText(label, color: FpColor.darkGrey),
        const HorizontalSpacer.medium(),
        Flexible(
          child: FpText(
            value,
            color: FpColor.darkGrey,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
