import 'package:flutter/material.dart';
import 'package:mobile_figure_pay_partner/fp_design/fp_design.dart';

class RecentActivityList extends StatelessWidget {
  RecentActivityList({required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).colorScheme.black)),
            GestureDetector(
              onTap: onTap,
              child: Text('View All',
                  style: Theme.of(context)
                      .textTheme
                      .small
                      .copyWith(color: Theme.of(context).colorScheme.primary3)),
            )
          ],
        ),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _listTile(context,
                title: 'CARD REWARD WALMART',
                subtitle: 'Feb 1, 2021',
                amount: '+\$2.10',
                status: 'PENDING',
                onTap: onTap),
            _divider(context),
            _listTile(context,
                title: 'WALMART',
                subtitle: 'Feb 1, 2021',
                amount: '-\$76.84',
                status: 'PENDING',
                onTap: onTap),
            _divider(context),
            _listTile(context,
                title: 'ATM OUT OF NETWORK FEE',
                subtitle: 'Feb 1, 2021',
                amount: '-\$2.50',
                status: '',
                onTap: onTap),
            _divider(context),
            _listTile(context,
                title: 'TARGET',
                subtitle: 'Jan 31, 2021',
                amount: '-\$32.17',
                status: 'PENDING',
                onTap: onTap),
          ],
        )
      ],
    );
  }

  Widget _listTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String amount,
    required String status,
    required Function() onTap,
  }) {
    return ListTile(
      dense: true,
      leading: FpIcon(
        FpIcons.reward,
        color: Colors.black,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .small
                  .copyWith(color: Theme.of(context).colorScheme.black)),
          Text(amount,
              style: Theme.of(context)
                  .textTheme
                  .headline7
                  .copyWith(color: Theme.of(context).colorScheme.black))
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subtitle,
              style: Theme.of(context)
                  .textTheme
                  .small
                  .copyWith(color: Theme.of(context).colorScheme.black)),
          Text(status,
              style: Theme.of(context)
                  .textTheme
                  .small
                  .copyWith(color: Theme.of(context).colorScheme.black))
        ],
      ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 8,
      thickness: 1,
      color: Theme.of(context).colorScheme.lightGrey,
    );
  }
}
