import 'package:flutter/material.dart';

class CustomListLayout extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const CustomListLayout({
    required this.itemCount,
    required this.itemBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Color bgColor;
  final Widget leading;
  final Widget title;
  final Widget subtitle;

  const CustomListTile({
    required this.bgColor,
    required this.leading,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                const SizedBox(height: 4),
                subtitle,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
