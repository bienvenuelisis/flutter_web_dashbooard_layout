import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_dashbooard_layout/extensions/context.dart';

import '../providers/app_settings_notifier.dart';
import '../utils.dart';
import 'header.dart';
import 'side_menu.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  final String title;

  final List<Breadcrumb>? breadcrumbs;

  MainScreen({
    this.child = const SizedBox.shrink(),
    required this.title,
    this.breadcrumbs,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (
        BuildContext context,
        T Function<T>(ProviderBase<Object, T>) watch,
        _,
      ) {
        AppSettingsModel settings = watch(appSettingsProvider);

        return Scaffold(
          body: SafeArea(
            child: settings.isSideMenuOpen
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // We want this side menu only for large screen
                      if (Responsive.isDesktop(context))
                        Expanded(
                          // default flex = 1
                          // and it takes 1/6 part of the screen
                          child: SideMenu(settings.menuKey, settings.bucket),
                        ),
                      Expanded(
                        // It takes 5/6 part of the screen
                        flex: 5,
                        child: _PageContent(
                          breadcrumbs: breadcrumbs,
                          title: title,
                          child: child,
                          toggleMenu: settings.toggleSideMenu,
                        ),
                      ),
                    ],
                  )
                : _PageContent(
                    breadcrumbs: breadcrumbs,
                    title: title,
                    child: child,
                    toggleMenu: settings.toggleSideMenu,
                  ),
          ),
        );
      },
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({
    Key? key,
    @required this.toggleMenu,
    this.child = const SizedBox.shrink(),
    @required this.title,
    @required this.breadcrumbs,
  }) : super(key: key);

  final VoidCallback? toggleMenu;

  final Widget? child;

  final String? title;

  final List<Breadcrumb>? breadcrumbs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Header(
              toggleMenu: toggleMenu,
            ),
            const SizedBox(height: 24),
            _PageHeader(
              title ?? "",
              breadcrumbs: breadcrumbs,
              width: context.width * (5 / 6),
            ),
            const SizedBox(height: 24),
            child ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader(
    this.title, {
    this.breadcrumbs = const [],
    required this.width,
    Key? key,
  }) : super(key: key);

  final String title;

  final List<Breadcrumb>? breadcrumbs;

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if ((breadcrumbs ?? []).isNotEmpty)
            Row(
              children: (breadcrumbs ?? [])
                  .map((breadcrumb) => Row(
                        children: [
                          TextButton(
                            child: Text(breadcrumb.title),
                            onPressed: () {
                              Navigator.of(context).pushNamed(breadcrumb.route);
                            },
                          ),
                          const Text(" /  "),
                        ],
                      ))
                  .toList()
                ..add(Row(
                  children: [
                    Text(title),
                  ],
                )),
            ),
        ],
      ),
    );
  }
}

class Breadcrumb extends Equatable {
  final String title;

  final String route;

  final Widget icon;

  final IconData? iconData;

  const Breadcrumb(
    this.title, {
    this.route = "/",
    this.iconData,
    this.icon = const SizedBox(),
  });

  @override
  List<Object> get props => [title, route];
}
