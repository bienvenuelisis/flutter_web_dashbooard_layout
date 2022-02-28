import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
    this.menuKey,
    this.bucket, {
    Key? key,
  }) : super(key: key);

  final PageStorageKey menuKey;

  final PageStorageBucket bucket;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: PageStorage(
        bucket: bucket,
        child: _SideMenuListView(menuKey),
      ),
    );
  }
}

class _SideMenuListView extends StatefulWidget {
  final PageStorageKey menuKey;

  const _SideMenuListView(this.menuKey, {Key? key}) : super(key: key);

  @override
  State<_SideMenuListView> createState() => __SideMenuListViewState();
}

class __SideMenuListViewState extends State<_SideMenuListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: widget.menuKey,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Image.asset(
                "assets/logo.jpg",
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                "Flutter Web",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: marron),
        const DrawerListTile(
          title: "Home",
          leading: Icon(
            Icons.home,
            color: Colors.black,
            size: 24,
          ),
          route: "/home",
        ),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Statistics"),
          ),
        ),
        const Divider(color: marron, height: 0.1),
        const DrawerListTile(
          title: "Notifications",
          leading: Icon(
            Icons.notification_add,
            size: 24,
            color: marron,
          ),
          route: "/administration/settings/notifications",
        ),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Settings"),
          ),
        ),
        const Divider(color: marron, height: 0.1),
        const DrawerListTile(
          title: "Alerts",
          leading: Icon(
            Icons.warning_amber_sharp,
            size: 24,
            color: marron,
          ),
          route: "/administration/settings/alertes",
        ),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Administration"),
          ),
        ),
        const Divider(color: marron, height: 0.1),
        const DrawerListTile(
          title: "User Management",
          leading: Icon(
            Icons.people_rounded,
            size: 24,
            color: marron,
          ),
          route: "/administration/users/manage",
        ),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Data"),
          ),
        ),
        const Divider(color: marron, height: 0.1),
        const DrawerListTile(
          title: "Documents",
          leading: Icon(
            Icons.description,
            size: 24,
            color: marron,
          ),
          route: "/administration/documents/viewer",
        ),
      ],
    );
  }
}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.leading,
    required this.route,
  }) : super(key: key);

  final String title;

  final Widget leading;

  final String route;

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  bool get selected => routeName == widget.route;

  String get routeName => ModalRoute.of(context)?.settings.name ?? "/";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      color: selected ? marron.withOpacity(0.2) : Colors.white,
      child: ListTile(
        selected: selected,
        selectedColor: marron,
        tileColor: selected ? marron : Colors.white,
        onTap: () {
          Navigator.pushNamed(context, widget.route);
        },
        leading: widget.leading,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
