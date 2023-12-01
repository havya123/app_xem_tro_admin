// ignore_for_file: constant_identifier_names

import 'package:admin_app_xem_tro/models/bar.dart';
import 'package:admin_app_xem_tro/models/users.dart';

enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}

class BarChartDataProcessor {
  static BarDataWeek calculateBarDataWeek(List<User> weeklyUserRegistrations, int role) {
    return BarDataWeek(
      monAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Monday, role),
      tueAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Tuesday, role),
      wedAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Wednesday, role),
      thurAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Thursday, role),
      friAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Friday, role),
      satAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Saturday, role),
      sunAmount: calculateTotalAmountForDay(weeklyUserRegistrations, DayOfWeek.Sunday, role),
    );
  }

  static BarDataMonth calculateBarDataMonth(List<User> monthlyUserRegistrations, int role) {
    return BarDataMonth(
      janAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.January, role),
      febAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.February, role),
      marAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.March, role),
      aprAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.April, role),
      mayAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.May, role),
      junAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.June, role),
      julAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.July, role),
      augAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.August, role),
      sepAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.September, role),
      octAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.October, role),
      novAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.November, role),
      decAmount: calculateTotalAmountForMonth(monthlyUserRegistrations, Month.December, role),
    );
  }

  static double calculateTotalAmountForDay(List<User> users, DayOfWeek day, int role) {
    return users
        .where((user) => user.createAt.weekday == day.index + 1 && user.role == role)
        .length
        .toDouble();
  }

  static double calculateTotalAmountForMonth(List<User> users, Month month, int role) {
    return users
        .where((user) => user.createAt.month == month.index + 1 && user.role == role)
        .length
        .toDouble();
  }
}
