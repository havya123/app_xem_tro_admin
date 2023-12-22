// ignore_for_file: must_be_immutable, unused_import

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/provider/combobox_value_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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
    Key? key,
    required this.title,
    required this.onValueChanged,
    required this.items,
    this.initialValue = "", // Default to an empty string
  }) : super(key: key);

  final String title;
  final String initialValue;
  final List<String> items;
  final Function(String) onValueChanged;

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = getInitialValue();
  }

  String getInitialValue() {
    return widget.initialValue.isNotEmpty
        ? widget.initialValue
        : widget.items.isNotEmpty
            ? widget.items.first
            : '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
              widget.onValueChanged(newValue);
            });
          },
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
