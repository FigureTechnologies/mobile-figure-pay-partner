import 'package:flutter/material.dart';

import '../theme.dart';

class DirectDepositBanner extends StatelessWidget {
  const DirectDepositBanner({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return _Banner(
      leading: Image.asset('assets/money_bag.png'),
      title: Text(
        'Get \$100 with Direct Deposit',
        style: Theme.of(context)
            .textTheme
            .headline7
            .copyWith(color: Theme.of(context).colorScheme.black),
      ),
      subtitle: Text('Click to learn more',
          style: Theme.of(context).textTheme.medium.copyWith(
              color: Theme.of(context).colorScheme.black,
              decoration: TextDecoration.underline)),
      backgroundImage: const AssetImage('assets/bg_notification_tile.png'),
      largeLeadingImage: true,
      showArrow: false,
      onTap: onTap,
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner(
      {Key? key,
      this.leading,
      this.title,
      this.subtitle,
      this.backgroundImage,
      this.largeLeadingImage = false,
      this.showArrow = true,
      this.onTap})
      : super(key: key);

  /// The widget to show as leading.
  final Widget? leading;

  /// The widget to show in the title.
  final Widget? title;

  /// The widget to show underneath the title.
  final Widget? subtitle;

  /// Will use [backgroundImage] for the background
  final AssetImage? backgroundImage;

  /// The callback to invoke when the card is tapped.
  final VoidCallback? onTap;

  /// This will move the [leading] image down to the bottom side of the card.
  final bool largeLeadingImage;

  /// This will show the chevron on the right.
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: backgroundImage != null
                ? Theme.of(context).colorScheme.white
                : Theme.of(context).colorScheme.primary3,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            image: backgroundImage != null
                ? DecorationImage(image: backgroundImage!, fit: BoxFit.fill)
                : null),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Stack(
            children: [
              if (largeLeadingImage) Positioned(bottom: 0.0, child: leading!),
              ListTile(
                horizontalTitleGap: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                leading: leading != null && !largeLeadingImage
                    ? SizedBox(
                        height: double.infinity,
                        child: leading,
                      )
                    : null,
                title: title != null
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: largeLeadingImage ? 69 : 0.0),
                        child: DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                          child: title!,
                        ),
                      )
                    : null,
                subtitle: subtitle != null
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: largeLeadingImage ? 69 : 0.0),
                        child: DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                          child: subtitle!,
                        ),
                      )
                    : null,
                onTap: onTap,
              ),
            ],
          ),
        ));
  }
}
