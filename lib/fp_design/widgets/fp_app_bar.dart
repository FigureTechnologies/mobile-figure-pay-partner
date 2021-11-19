part of fp_design;

enum FpAppBarType { light, dark }

/// Custom `AppBar` for the purpose of being able to use a custom back and
/// close buttons with the same effect as `automaticallyImplyLeading` to add
/// close button when `fullscreenDialog = true` and back buttom when `false`
/// as well when using [showModalBottomSheet]
class FpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FpAppBar({
    Key? key,
    this.barType = FpAppBarType.dark,
    this.transparent = false,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.onDismissed,
    this.nestedPopHandler,
  }) : super(key: key);

  final FpAppBarType barType;
  final Widget? leading;

  /// Sets the backgroundColor of the app bar to be transparent
  final bool transparent;

  /// Formatted title `Text` widget is auto-created based on [barType]
  final String? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  /// optional additional logic to run before dismissing view
  final Function? onDismissed;

  // /// Use when wanting to pop a nested [Navigator]/[FlowBuilder]
  final Function? nestedPopHandler;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop =
        nestedPopHandler != null || (parentRoute?.canPop ?? false);
    // use close button for routes with [fullScreenDialog] set to true or
    // [PopupRoute] which is usually a [_ModalBottomSheetRoute]
    final bool useCloseButton =
        (parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog) ||
            parentRoute is PopupRoute;
    final bool isDark = barType == FpAppBarType.dark;

    var leading = this.leading;
    if (leading == null) {
      if (canPop) {
        leading = _iconButton(context, useCloseButton);
      }
    }

    Widget? title = this.title != null
        ? Text(
            this.title!,
            style: theme.textTheme.bodyText1!.copyWith(
                color: isDark
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.darkGrey),
          )
        : null;

    return AppBar(
      leading: leading,
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
      bottom: bottom,
      elevation: 0,
      backgroundColor: transparent
          ? Colors.transparent
          : isDark
              ? Colors.black
              : theme.colorScheme.background,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  Widget _iconButton(BuildContext context, bool useCloseButton) {
    final theme = Theme.of(context);
    final icon = FpIcon(useCloseButton ? FpIcons.close : FpIcons.back,
        color: barType == FpAppBarType.dark
            ? Colors.white
            : theme.colorScheme.black);

    return IconButton(
      icon: icon,
      onPressed: () async {
        await onDismissed?.call();

        if (nestedPopHandler != null) {
          nestedPopHandler!();
        } else {
          Navigator.of(context).pop();
        }
      },
      splashRadius: 0.1,
    );
  }
}
