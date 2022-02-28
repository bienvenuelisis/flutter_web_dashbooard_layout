import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_dashbooard_layout/extensions/date.dart';
import 'package:flutter_web_dashbooard_layout/utils.dart';

import '../constants/colors.dart';
import '../providers/app_settings_notifier.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.toggleMenu,
  }) : super(key: key);

  final VoidCallback? toggleMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: Responsive.isDesktop(context),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              if (toggleMenu != null) toggleMenu!();
            },
          ),
        ),
        const SizedBox(width: 10),
        Visibility(
          visible: Responsive.isMobile(context),
          child: Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        ),
        const Expanded(child: SearchField()),
        const _NotificationsHeader(),
        Consumer(
          builder: (context, watch, _) {
            AppSettingsModel settings = watch(appSettingsProvider);

            return Padding(
              padding: const EdgeInsets.only(left: 36),
              child: IconButton(
                icon: Icon(
                  settings.nightMode
                      ? Icons.mode_night_rounded
                      : Icons.wb_sunny,
                ),
                onPressed: () {
                  settings.nightMode = !settings.nightMode;
                },
              ),
            );
          },
        ),
        const ProfileCard(),
      ],
    );
  }
}

class _NotificationsHeader extends StatelessWidget {
  const _NotificationsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        alignment: Alignment.centerLeft,
        customButton: Badge(
          badgeContent: const Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          child: const Icon(
            Icons.notifications,
            color: primaryColor,
          ),
          badgeColor: red,
        ),
        dropdownOverButton: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        value: 0,
        itemHeight: 100,
        dropdownWidth: 400,
        enableFeedback: true,
        onChanged: (value) {},
        dropdownPadding: const EdgeInsets.only(right: 15),
        items: [
          "Connecting to your device from a new device.",
          "The last action did not succeed.",
          "New requests have been made. Take a look.",
          "You have received a new contact request.",
          "You have received a new message.",
        ]
            .map(
              (notification) => DropdownMenuItem(
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: const SizedBox(
                      width: 50,
                      child: Icon(Icons.person),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          child: RichText(
                            text: TextSpan(
                              text: notification,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline),
                            Text(
                              DateTime.now().str,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                value: 1,
                onTap: () {
                  Navigator.pushNamed(context, "/notifications/view?id=1");
                },
              ),
            )
            .toList()
          ..insert(
            0,
            DropdownMenuItem(
              child: Row(
                children: const [
                  Text("Notifications"),
                  SizedBox(width: 24),
                ],
              ),
              value: 0,
            ),
          ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24 / 2,
      ),
      decoration: BoxDecoration(
        //color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<int>(
          alignment: Alignment.centerLeft,
          customButton: Row(
            children: const [
              Icon(
                Icons.person,
                size: 36,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24 / 2),
                child: Text("John Doe"),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
          dropdownOverButton: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          value: 0,
          customItemsIndexes: const [1, 2, 3, 4],
          dropdownPadding: const EdgeInsets.only(right: 9),
          dropdownWidth: 240,
          enableFeedback: true,
          onChanged: (value) {},
          items: [
            DropdownMenuItem(
              value: 0,
              child: Row(
                children: const [
                  Icon(Icons.person, size: 36),
                  SizedBox(width: 24),
                  Text("User authorized"),
                ],
              ),
            ),
            const DropdownMenuItem(child: Divider(color: marron)),
            DropdownMenuItem(
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              value: 1,
              onTap: () {
                Navigator.pushNamed(context, "/profile");
              },
            ),
            DropdownMenuItem(
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              value: 2,
              onTap: () {
                Navigator.pushNamed(context, "/settings/general");
              },
            ),
            DropdownMenuItem(
              child: const ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
              ),
              value: 3,
              onTap: () {
                Navigator.pushNamed(context, "/logout");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24 / 2),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          fillColor: marron.withOpacity(0.1),
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  final Widget pic;

  const ProfilePic(this.pic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            child: pic,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.white),
                ),
                color: const Color(0xFFF5F6F9),
                onPressed: () {},
                child: const Icon(Icons.camera_alt),
              ),
            ),
          )
        ],
      ),
    );
  }
}
