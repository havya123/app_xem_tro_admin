// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/config/widget/app_bar_draw.dart';
import 'package:admin_app_xem_tro/provider/bar_provider.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Manage_acc_regi/graph/bart_grap_week.dart';
import 'package:admin_app_xem_tro/config/widget/navigation_draw.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Manage_acc_regi/graph/bart_grap_year.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late DateTime selectedDate;
  late DateTime selectedWeekStart;
  late DateTime selectedWeekEnd;
  late DateTime selectedYear;

  GlobalKey<MyBarGraphWeekState> userBarGraphWeekKey = GlobalKey();
  GlobalKey<MyBarGraphYearState> userBarGraphYearKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedYear = DateTime.now();
    initializeWeek(selectedDate);
  }

  void initializeWeek(DateTime date) {
    selectedWeekStart = date.subtract(Duration(days: date.weekday - 1));
    selectedWeekEnd = date.add(Duration(days: 7 - date.weekday));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      drawer: const NavigationDraw(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(padding(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius(context)),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chọn ngày trong tuần'),
                        IconButton(
                          onPressed: () {
                            _selectDate(context,
                                isNextWeek: false, isPreviousWeek: false);
                          },
                          icon: Icon(FontAwesomeIcons.calendarWeek),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            _selectDate(context,
                                isNextWeek: false, isPreviousWeek: true);
                          },
                          icon: Icon(FontAwesomeIcons.arrowLeft),
                        ),
                        Text(
                          '${DateFormat('dd/MM/yyyy').format(selectedWeekStart)} - ${DateFormat('dd/MM/yyyy').format(selectedWeekEnd)}',
                          style: TextStyle(fontSize: 15),
                        ),
                        IconButton(
                          onPressed: () {
                            _selectDate(context,
                                isNextWeek: true, isPreviousWeek: false);
                          },
                          icon: Icon(FontAwesomeIcons.arrowRight),
                        ),
                      ],
                    ),
                    spaceHeight(context),
                    Center(
                      child: SizedBox(
                        height: getHeight(context, height: 0.35),
                        child: MyBarGraphWeek(
                          user: 0,
                          landlord: 1,
                          key: userBarGraphWeekKey,
                          selectedWeekStart: selectedWeekStart,
                          selectedWeekEnd: selectedWeekEnd,
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidSquare,
                              color: Colors.blue,
                            ),
                            title: Text("Người dùng"),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidSquare,
                              color: Colors.green,
                            ),
                            title: Text("Chủ trọ"),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Thông kê đăng ký Người dùng và Chủ trọ theo tuần'
                            .toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              spaceHeight(context),
              Container(
                padding: EdgeInsets.all(padding(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius(context)),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chọn năm'),
                        IconButton(
                          onPressed: () {
                            _selectYear(context,
                                isNextYear: false, isPreviousYear: false);
                          },
                          icon: Icon(FontAwesomeIcons.calendarDays),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            _selectYear(context,
                                isNextYear: false, isPreviousYear: true);
                          },
                          icon: Icon(FontAwesomeIcons.arrowLeft),
                        ),
                        Text(
                          '${selectedYear.year}',
                          style: TextStyle(fontSize: 15),
                        ),
                        IconButton(
                          onPressed: () {
                            _selectYear(context,
                                isNextYear: true, isPreviousYear: false);
                          },
                          icon: Icon(FontAwesomeIcons.arrowRight),
                        ),
                      ],
                    ),
                    spaceHeight(context),
                    Center(
                      child: SizedBox(
                        height: getHeight(context, height: 0.35),
                        child: MyBarGraphYear(
                          user: 0,
                          landlord: 1,
                          selectedYear: selectedYear,
                          key: userBarGraphYearKey,
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidSquare,
                              color: Colors.blue,
                            ),
                            title: Text("Người dùng"),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidSquare,
                              color: Colors.green,
                            ),
                            title: Text("Chủ trọ"),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Thông kê đăng ký Người dùng và Chủ trọ theo năm'
                            .toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isNextWeek, required bool isPreviousWeek}) async {
    DateTime newSelectedDate = selectedDate;

    if (isNextWeek) {
      newSelectedDate = selectedDate.add(Duration(days: 7));
    } else if (isPreviousWeek) {
      newSelectedDate = selectedDate.subtract(Duration(days: 7));
    }

    if (!isNextWeek && !isPreviousWeek) {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: newSelectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
          initializeWeek(pickedDate);
        });
      }
    } else {
      setState(() {
        selectedDate = newSelectedDate;
        initializeWeek(newSelectedDate);
      });
    }

    // Gọi fetchUserRegistrations và updateGraph
    Provider.of<BarDataProvider>(context, listen: false)
        .fetchUserRegistrations(selectedWeekStart, selectedWeekEnd)
        .then((_) {
      userBarGraphWeekKey.currentState?.updateGraph();
    });
  }

  Future<void> _selectYear(BuildContext context,
      {required bool isNextYear, required bool isPreviousYear}) async {
    DateTime newYearDate = selectedYear;

    if (isNextYear) {
      newYearDate = selectedYear.add(Duration(days: 365));
    } else if (isPreviousYear) {
      newYearDate = selectedYear.subtract(Duration(days: 365));
    }

    if (!isNextYear && !isPreviousYear) {
      DateTime? pickedYear = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: newYearDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedYear != null) {
        setState(() {
          selectedYear = pickedYear;
        });
      }
    } else {
      setState(() {
        selectedYear = newYearDate;
      });
    }
    Provider.of<BarDataProvider>(context, listen: false)
        .fetchUserRegistrationsYear(selectedYear)
        .then((_) {
      userBarGraphYearKey.currentState?.updateGraph();
    });
  }
}
