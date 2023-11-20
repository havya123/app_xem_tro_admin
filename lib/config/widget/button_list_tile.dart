// ignore_for_file: must_be_immutable

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonListTile extends StatefulWidget {
  const ButtonListTile({
    super.key,
    required this.title,
    this.icon,
    this.onPress,
    this.iconbutton,
    this.onPressIcon,
  });

  final String title;
  final IconData? icon, iconbutton;
  final VoidCallback? onPress, onPressIcon;

  @override
  State<ButtonListTile> createState() => _ButtonListTileState();
}

class _ButtonListTileState extends State<ButtonListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceHeight(context, height: 0.02),
        ListTile(
          onTap: widget.onPress,
          leading: Container(
            width: getWidth(context, width: 0.1),
            height: getHeight(context, height: 0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(4, 4))
                ]),
            child: Icon(
              widget.icon,
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: IconButton(
              icon: Icon(widget.iconbutton), onPressed: widget.onPressIcon),
        ),
      ],
    );
  }
}


class ComboBox extends StatefulWidget {
  const ComboBox({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  String dropdownValue = "Week";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(FontAwesomeIcons.angleDown),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: const [
              DropdownMenuItem(
                value: "Week",
                child: Text("Week"),
              ),
              DropdownMenuItem(
                value: "Month",
                child: Text("Month"),
              ),
            ],
          ),
        ),
        spaceHeight(context, height: 0.02)
      ],
    );
  }
}
